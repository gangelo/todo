# frozen_string_literal: true

module Doto
  module Presenters
    class BasePresenterEx
      def initialize(options: {})
        @options = options&.dup || {}
      end

      private

      attr_accessor :options
    end
  end
end
