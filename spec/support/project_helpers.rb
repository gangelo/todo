# frozen_string_literal: true

module ProjectHelpers
  def current_project
    Todo::Models::Project.current_project
  end

  def default_project
    Todo::Models::Project.default_project
  end
end
