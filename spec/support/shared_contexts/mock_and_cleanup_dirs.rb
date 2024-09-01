# frozen_string_literal: true

RSpec.shared_context 'when dir mock and cleanup is needed' do
  before do
    # Mock Dir.home and Dir.tmpdir to return the temporary directories
    allow(Dir).to receive_messages(home: temp_folder, tmpdir: temp_folder)
    allow(Tempfile).to receive(:new).with('todo').and_return(temp_file)

    FileUtils.mkdir_p(Todo::Support::Fileable.root_folder)

    todo_folder = File.join(temp_folder, 'todo')
    FileUtils.mkdir_p(todo_folder)
    allow(Todo::Support::Fileable).to receive_messages(migration_version_folder: todo_folder, migration_version_path: File.join(todo_folder, Todo::Support::Fileable::MIGRATION_VERSION_FILE_NAME))

    fixture_path = File.join('spec', 'fixtures', 'files', 'current_project.json')
    FileUtils.cp(fixture_path, Todo::Support::Fileable.current_project_file)

    # Create a default project folder.
    default_project_folder = File.join(Todo::Support::Fileable.projects_folder,
      Todo::Models::Configuration::DEFAULT_CONFIGURATION[:default_project])
    FileUtils.mkdir_p(default_project_folder)

    # Create the default project.json file.
    project_json = File.join('spec', 'fixtures', 'files', 'project.json')
    FileUtils.cp(project_json, File.join(default_project_folder, File.basename(project_json)))

    FileUtils.mkdir_p(Todo::Support::Fileable.config_folder)
    FileUtils.mkdir_p(Todo::Support::Fileable.entries_folder)
    FileUtils.mkdir_p(Todo::Support::Fileable.themes_folder)

    create(:color_theme)
  end

  after do
    # Clean up the files and directories created within the temporary directory.
    FileUtils.rm_rf(File.join(temp_folder, 'todo'))
    FileUtils.rm_rf(File.join(temp_folder, '.todo'))
  end

  let(:temp_folder) { Dir.tmpdir }
  let(:temp_file) { Tempfile.new('todo', temp_folder) }
end

RSpec.configure do |config|
  config.include_context 'when dir mock and cleanup is needed'
end
