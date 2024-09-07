# frozen_string_literal: true

module ProjectHelpers
  def current_project
    Doto::Models::Project.current_project
  end

  def default_project
    Doto::Models::Project.default_project
  end
end
