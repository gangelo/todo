# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/blank'
require 'i18n'
require 'thor'
require 'time'

I18n.load_path += Dir[File.join(__dir__, 'locales/**/*', '*.yml')]
# I18n.default_locale = :en # (note that `en` is already the default!)

Dir.glob("#{__dir__}/core/**/*.rb").each do |file|
  require file
end

Array.include(WrapAndJoin)
Hash.include(ColorThemeColors)
Hash.include(ColorThemeMode)

require_relative 'todo/env'
require 'pry-byebug' if Todo.env.development?

Dir.glob("#{__dir__}/todo/**/*.rb").each { |file| require file }

unless Todo.env.test? || Todo.env.development?
  # NOTE: Add a new migration service to the array whenever a new migration is created.
  options = { pretend: false }
  migration_services = [
    Todo::Migration::V20230613121411::Service.new(options: options),
    Todo::Migration::V20240210161248::Service.new(options: options)
  ]
  Todo::Migration::Migrator.migrate_if!(migration_services: migration_services)
end
