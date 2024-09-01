# frozen_string_literal: true

FactoryBot.define do
  factory :color_theme, class: 'Todo::Models::ColorTheme' do
    theme_name { Todo::Models::ColorTheme::DEFAULT_THEME_NAME.dup }
    theme_hash { Todo::Models::ColorTheme::DEFAULT_THEME.dup }

    initialize_with do
      unless theme_name == Todo::Models::ColorTheme::DEFAULT_THEME_NAME
        theme_hash[:description] = "#{theme_name.capitalize} theme"
      end
      new(theme_name: theme_name, theme_hash: theme_hash)
    end
  end
end
