# frozen_string_literal: true

require_relative '../base_cli'
require_relative '../support/ask'

module Todo
  module Subcommands
    class BaseSubcommand < Todo::BaseCLI
      include Support::Ask
    end
  end
end
