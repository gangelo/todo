# frozen_string_literal: true

require_relative '../../migration/version'

module Todo
  module Presenters
    module Import
      module ImportEntry
        def overriding_project?
          options&.fetch(:override, false)
        end

        private

        def import_entry?(entry_group_entry)
          entry_group_entry[:version].to_i == Todo::Migration::VERSION &&
            (overriding_project? || entry_group_entry[:project_name] == project_name)
        end
      end
    end
  end
end
