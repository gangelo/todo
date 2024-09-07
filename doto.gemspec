# frozen_string_literal: true

require_relative 'lib/doto/version'

Gem::Specification.new do |spec|
  spec.name = 'doto'
  spec.version = Doto::VERSION

  spec.authors      = ['Gene M. Angelo, Jr.']
  spec.email        = ['public.gma@gmail.com']

  spec.summary      = 'doto TODO list mini-manager.'
  spec.description  = <<-DESC
    doto is ruby gem that enables anyone to record, keep track of and manage their daily TODO lists.

    * doto uses no network connections whatsoever.
    * doto stores all of its data locally, in .json files.
    * doto is a simple (but powerful) command-line tool for users who love to work within the terminal.
    * doto versioning follows the semantic versioning standard (MAJOR.MINOR.PATCH).
  DESC
  spec.homepage = 'https://github.com/gangelo/doto'
  spec.license = 'MIT'
  spec.required_ruby_version = ['>= 3.0.7', '< 4.0']

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['documentation_uri'] = 'https://github.com/gangelo/doto/wiki'
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/gangelo/doto/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 7.0.8', '< 8.0'
  spec.add_dependency 'activemodel', '>= 7.0.8', '< 8.0'
  spec.add_dependency 'colorize', '>= 1.1', '< 2.0'
  spec.add_dependency 'os', '>= 1.1', '< 2.0'
  spec.add_dependency 'thor', '>= 1.2', '< 2.0'
  spec.add_dependency 'thor_nested_subcommand', '>= 1.0', '< 2.0'
  spec.add_dependency 'tzinfo-data', '~> 1.2024', '>= 1.2024.1'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.post_install_message = <<~POST_INSTALL
    Thank you for installing doto.

    Run `doto` from your command line to get started.

    View the doto README.md here: https://github.com/gangelo/doto
    View the doto CHANGELOG.md: https://github.com/gangelo/doto/blob/main/CHANGELOG.md

                *
               ***
             *******
            *********
     ***********************
        *****************
          *************
         ******* *******
        *****       *****
       ***             ***
      **                 **

    Using doto? doto is made available free of charge. Please consider giving doto a STAR on GitHub as well as sharing doto with your fellow developers on social media.

    Knowing that doto is being used and appreciated is a great motivator to continue developing and improving doto.

    >>> Star it on github: https://github.com/gangelo/doto
    >>> Share on social media: https://rubygems.org/gems/doto

    Thank you!

    <3 Gene

    doto uses "Projects"! Run `doto help project` to get started. Or, visit the doto wiki for more information: https://github.com/gangelo/doto/wiki/Managing-doto-Projects
  POST_INSTALL
end
