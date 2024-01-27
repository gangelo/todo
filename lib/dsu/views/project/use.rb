# frozen_string_literal: true

require_relative '../../env'
require_relative '../../models/color_theme'
require_relative '../../support/ask'
require_relative '../../support/color_themable'

module Dsu
  module Views
    module Project
      class Use
        include Support::Ask
        include Support::ColorThemable

        attr_reader :presenter

        def initialize(presenter:, options: {})
          @presenter = presenter
          @options = options&.dup || {}
          @color_theme = Models::ColorTheme.find(theme_name: theme_name)
        end

        def render
          return display_project_does_not_exists if presenter.project_does_not_exist?
          return display_project_errors if presenter.project_errors.any?

          response = display_project_use_prompt
          if presenter.respond response: response
            display_using_project_message
          else
            display_use_project_cancelled_message
          end
        rescue StandardError => e
          puts apply_theme(e.message, theme_color: color_theme.error)
          puts apply_theme(e.backtrace_locations.join("\n"), theme_color: color_theme.error) if Dsu.env.local?
        end

        private

        attr_reader :color_theme, :options

        def display_project_use_prompt
          response = ask_while(prompt_with_options(prompt: use_prompt,
            options: use_prompt_options), options: options) do |input|
            message = I18n.t('information.input.try_again', options: use_prompt_options.join(','))
            puts apply_theme(message, theme_color: color_theme.info) unless use_prompt_options.include?(input)
            use_prompt_options.include?(input)
          end
          response == use_prompt_options.first
        end

        def display_use_project_cancelled_message
          message = I18n.t('subcommands.project.messages.cancelled')
          puts apply_theme(message, theme_color: color_theme.info)
        end

        def display_project_errors
          errors = presenter.project_errors.join("\n")
          puts apply_theme(errors, theme_color: color_theme.error)
        end

        def display_project_does_not_exists
          message = I18n.t('subcommands.project.messages.does_not_exist',
            project_name: presenter.project_name)
          puts apply_theme(message, theme_color: color_theme.error)
        end

        def display_using_project_message
          message = I18n.t('subcommands.project.use.messages.using_project',
            project_name: presenter.project_name)
          puts apply_theme(message, theme_color: color_theme.success)
        end

        def use_prompt
          I18n.t('subcommands.project.use.prompts.use_confirm',
            project_name: presenter.project_name,
            description: presenter.project_description)
        end

        def use_prompt_options
          I18n.t('subcommands.project.use.prompts.use_options')
        end

        def theme_name
          @theme_name ||= options.fetch(:theme_name, Models::Configuration.new.theme_name)
        end
      end
    end
  end
end
