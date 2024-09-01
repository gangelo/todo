# frozen_string_literal: true

RSpec.describe 'Todo config features', type: :feature do
  subject(:cli) { Todo::CLI.start(args) }

  let(:args) { %w[config] }
  let(:with_config) do
    file_path = 'spec/fixtures/files/.todo'
    file_name = File.basename(file_path)
    destination_path = File.join(Todo::Support::Fileable.config_folder, file_name)
    FileUtils.cp(file_path, destination_path)
  end

  context "when 'todo help config' is called" do
    let(:args) { %w[help config] }

    it 'displays help' do
      expect { cli }.to output(/Commands:.*rspec config/m).to_stdout
    end
  end

  context "when 'todo config info' is called" do
    let(:args) { %w[config info] }
    let(:expected_output) do
      /.+Configuration file contents.+\)/m
    end

    it 'displays config info' do
      expect { cli }.to output(expected_output).to_stdout
    end
  end
end
