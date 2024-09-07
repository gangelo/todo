# frozen_string_literal: true

require_relative '../base_cli'
require_relative '../support/ask'

module Doto
  module Subcommands
    class BaseSubcommand < Doto::BaseCLI
      include Support::Ask
    end
  end
end
