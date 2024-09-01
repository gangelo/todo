# frozen_string_literal: true

module Todo
  module Presenters
    module Project
      module Defaultable
        private

        def make_default?
          options.fetch(:default, false)
        end
      end
    end
  end
end
