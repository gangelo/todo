# frozen_string_literal: true

RSpec.describe Todo::Support::Descriptable, type: :module do
  subject(:descriptable) do
    Class.new do
      include Todo::Support::Descriptable

      attr_reader :description

      def initialize(description)
        @description = description
      end
    end.new(description)
  end

  let(:max_desc) { Todo::Support::ShortString::SHORT_STRING_MAX_COUNT }

  describe '#short_description' do
    context 'when description is nil' do
      let(:description) { nil }

      it 'returns an empty string' do
        expect(descriptable.short_description).to eq('')
      end
    end

    context 'when description is an empty string' do
      let(:description) { '' }

      it 'returns an empty string' do
        expect(descriptable.short_description).to eq('')
      end
    end

    context 'when description is a single token' do
      context 'when description length is equal to SHORT_STRING_MAX_COUNT' do
        let(:description) { 'x' * max_desc }

        it 'returns the shortened description' do
          expect(descriptable.short_description).to eq(description)
        end
      end

      context 'when description length is less than SHORT_STRING_MAX_COUNT' do
        let(:description) { 'x' * (max_desc - 5) }

        it 'returns the shortened description' do
          expect(descriptable.short_description).to eq(description)
        end
      end

      context 'when description length is greater than SHORT_STRING_MAX_COUNT' do
        let(:description) { 'x' * (max_desc + 3) }
        let(:expected_short_description) { "#{'x' * (max_desc - 3)}..." }

        it 'returns the shortened description' do
          expect(descriptable.short_description).to eq(expected_short_description)
        end
      end
    end

    context 'when description is multiple tokens' do
      context 'when description length is equal to SHORT_STRING_MAX_COUNT' do
        let(:description) { description_having }

        it 'returns the shortened description' do
          expect(descriptable.short_description).to eq(description)
        end
      end

      context 'when description length is less than SHORT_STRING_MAX_COUNT' do
        let(:description) { description_having(max_length: max_desc - 5) }

        it 'returns the shortened description' do
          expect(descriptable.short_description).to eq(description)
        end
      end

      context 'when description length is greater than SHORT_STRING_MAX_COUNT' do
        let(:description) { 'This is a string of words greater than 25 chars in total' }

        it 'returns the shortened description without breaking up any words' do
          expect(descriptable.short_description).to eq('This is a string of...')
        end
      end
    end
  end
end
