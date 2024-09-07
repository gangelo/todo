# frozen_string_literal: true

RSpec.describe 'Doto info features', type: :feature do
  subject(:cli) { Doto::CLI.start(args) }

  context "when 'doto help version' is called" do
    let(:args) { %w[help version] }

    it 'displays help' do
      expect { cli }.to output(/Usage:.*rspec version/m).to_stdout
    end
  end

  context "when 'doto version' is called" do
    subject(:cli_output) do
      Doto::Services::StdoutRedirectorService.call do
        cli
      end
    end

    let(:args) { %w[version] }
    let(:version) { "v#{Doto::VERSION}" }

    it 'displays the configuration version' do
      escaped_version = Regexp.escape(version)
      expect(strip_escapes(cli_output)).to match(/.*^#{escaped_version}.*/m)
    end
  end
end
