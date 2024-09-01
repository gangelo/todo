# frozen_string_literal: true

RSpec.describe 'Todo info features', type: :feature do
  subject(:cli) { Todo::CLI.start(args) }

  context "when 'todo help version' is called" do
    let(:args) { %w[help version] }

    it 'displays help' do
      expect { cli }.to output(/Usage:.*rspec version/m).to_stdout
    end
  end

  context "when 'todo version' is called" do
    subject(:cli_output) do
      Todo::Services::StdoutRedirectorService.call do
        cli
      end
    end

    let(:args) { %w[version] }
    let(:version) { "v#{Todo::VERSION}" }

    it 'displays the configuration version' do
      escaped_version = Regexp.escape(version)
      expect(strip_escapes(cli_output)).to match(/.*^#{escaped_version}.*/m)
    end
  end
end
