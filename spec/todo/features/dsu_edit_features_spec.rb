# frozen_string_literal: true

RSpec.describe 'Todo edit features', type: :feature do
  subject(:cli) { Todo::CLI.start(args) }

  shared_examples 'the entry group for the entry date is edited' do
    before do
      with_entries
      mock_editor(entry_group: entry_group)
    end

    let(:entry_group) { Todo::Models::EntryGroup.find(time: entry_date) }
    let(:expected_output) do
      Todo::Views::EntryGroup::Edit.new(entry_group: entry_group).render
    end

    it 'edits entry group for the date' do
      expect { cli }.to output(expected_output).to_stdout
    end
  end

  let(:with_entries) do
    Dir.glob(File.join('spec/fixtures/files/entries', '*')).each do |file_path|
      file_name = File.basename(file_path)
      destination_path = File.join(Todo::Support::Fileable.entries_folder, file_name)
      FileUtils.cp(file_path, destination_path)
    end
  end

  context "when 'todo help edit' is called" do
    let(:args) { %w[help edit] }

    it 'displays help' do
      expect { cli }.to output(/Commands:.*rspec edit/m).to_stdout
    end
  end

  context "when 'todo edit date DATE' is called" do
    let(:args) { ['edit', 'date', Todo::Support::TimeFormatable.yyyy_mm_dd(time: entry_date)] }
    let(:entry_date) { Time.parse('2023-06-16') }

    it_behaves_like 'the entry group for the entry date is edited'
  end

  context "when 'todo edit --today' is called" do
    let(:args) { ['edit', '--today', Todo::Support::TimeFormatable.yyyy_mm_dd(time: entry_date)] }
    let(:entry_date) { Time.parse('2023-06-16') }

    it_behaves_like 'the entry group for the entry date is edited'
  end

  context "when 'todo edit --tomorrow' is called" do
    let(:args) { ['edit', '--tomorrow', Todo::Support::TimeFormatable.yyyy_mm_dd(time: entry_date)] }
    let(:entry_date) { Time.parse('2023-06-17') }

    it_behaves_like 'the entry group for the entry date is edited'
  end

  context "when 'todo edit --yesterday' is called" do
    let(:args) { ['edit', '--yesterday', Todo::Support::TimeFormatable.yyyy_mm_dd(time: entry_date)] }
    let(:entry_date) { Time.parse('2023-06-15') }

    it_behaves_like 'the entry group for the entry date is edited'
  end
end

def mock_editor(entry_group:)
  allow(Todo::Services::EntryGroup::EditorService).to \
    receive(:call).with(entry_group: entry_group)
  allow(Todo::Services::StdoutRedirectorService).to \
    receive(:call).and_return(Todo::Views::EntryGroup::Edit.new(entry_group: entry_group).render_as_string)
  editor = Todo::Models::Configuration::DEFAULT_CONFIGURATION[:editor]
  allow(Kernel).to receive(:system).with("${EDITOR:-#{editor}} #{temp_file.path}").and_return(true)
end
