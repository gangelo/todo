# frozen_string_literal: true

module Todo
  module Support
    module Fileable
      MIGRATION_VERSION_FILE_NAME = 'migration_version.json'

      def todo_folder
        File.join(root_folder, 'todo')
      end

      # Configuration

      def config_folder
        root_folder
      end

      def config_file_name
        '.todo'
      end

      def config_path
        File.join(config_folder, config_file_name)
      end

      # Entries

      def entries_folder
        project_folder = project_folder_for(project_name: Models::Project.current_project_name)
        File.join(project_folder, 'entries')
      end

      def entries_file_name(time:, file_name_format: nil)
        file_name_format ||= '%Y-%m-%d.json'
        time.strftime(file_name_format)
      end

      def entries_path(time:, file_name_format: nil)
        File.join(entries_folder, entries_file_name(time: time, file_name_format: file_name_format))
      end

      # Themes

      def themes_folder
        File.join(todo_folder, 'themes')
      end

      def themes_path(theme_name:)
        File.join(themes_folder, theme_file_name(theme_name: theme_name))
      end

      def theme_file_name(theme_name:)
        "#{theme_name}.json"
      end

      # Migration

      def migration_version_folder
        File.join(todo_folder)
      end

      def migration_version_path
        File.join(migration_version_folder, MIGRATION_VERSION_FILE_NAME)
      end

      # Base folders

      def root_folder
        Dir.home
      end

      def temp_folder
        Dir.tmpdir
      end

      def gem_dir
        Gem.loaded_specs['todo'].gem_dir
      end

      # Seed data files and folders

      def seed_data_todo_folder_for(migration_version:)
        File.join(gem_dir, 'lib/seed_data', migration_version.to_s, 'todo')
      end

      def seed_data_todo_configuration_for(migration_version:)
        File.join(gem_dir, 'lib/seed_data', migration_version.to_s, '.todo')
      end

      # Projects

      # Returns the folder where all the projects are stored.
      def projects_folder
        File.join(todo_folder, 'projects')
      end

      # Current project

      # Contains the name of the file that contains the current
      # todo project currently being used.
      def current_project_file_name
        'current_project.json'
      end

      # The complete path to the current project file.
      def current_project_file
        File.join(todo_folder, current_project_file_name)
      end

      # Project helpers

      # Returns the path of the project with the given name.
      def project_folder_for(project_name:)
        raise I18n.t('errors.project_name_invalid', project_name: '{{blank}}') if project_name.blank?

        File.join(projects_folder, project_name)
      end
      alias project_folder project_folder_for

      def project_file_for(project_name:)
        project_folder = project_folder_for(project_name: project_name)

        File.join(project_folder, 'project.json')
      end
      alias project_file project_file_for

      # Backup folders

      def backup_folder_for(migration_version:)
        File.join(root_folder, "todo-#{migration_version}-backup")
      end

      extend self # rubocop:disable Style/ModuleFunction
    end
  end
end
