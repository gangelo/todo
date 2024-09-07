# frozen_string_literal: true

require_relative '../env'
require_relative '../models/color_theme'
require_relative '../models/project'
require_relative '../services/stderr_redirector_service'
require_relative '../views/shared/error'
require_relative 'color_themable'

module Doto
  module Support
    module CommandHookable
      class << self
        def included(base)
          base.extend(ColorThemable)
          base.extend(ClassMethods)
        end
      end

      module ClassMethods
        def start(args = ARGV, options = {})
          display_doto_header unless suspend_header?(args, options)
          stderror = Services::StderrRedirectorService.call do
            super
          end
          display_errors_if(stderror)
          display_doto_footer
        end

        def display_doto_header
          if Doto.env.screen_shot_mode?
            puts apply_theme('Running screen shot mode!', theme_color: color_theme.warning)
            puts "#{Doto.env.screen_shot_prompt} doto #{ARGV.join(' ')}"
          end
        end

        def display_doto_footer
          puts apply_theme('_' * 50, theme_color: color_theme.doto_footer)
          # TODO: I18n.
          puts apply_theme("doto v#{Doto::VERSION} | Project: #{project} | Theme: #{color_theme.theme_name}",
            theme_color: color_theme.doto_footer)
        end

        private

        def project
          Models::Project.current_project_name
        end

        def suspend_header?(args, _options)
          return false unless args.count > 1

          # TODO: I18n?
          true if args[0] == 'theme' && %w[use delete].include?(args[1])
        end

        def display_errors_if(stderror_string)
          stderror_string = stderror_string.strip
          return unless stderror_string.present?

          errors = stderror_string.split("\n").map(&:strip)
          Views::Shared::Error.new(messages: errors, options: options.merge({ ordered_list: false })).render
        end

        def color_theme
          Models::ColorTheme.current_or_default
        end
      end
    end
  end
end
