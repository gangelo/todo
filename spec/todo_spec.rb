# frozen_string_literal: true

RSpec.describe Todo do
  it 'has a version number' do
    expect(Todo::VERSION).to_not be_nil
  end
end
