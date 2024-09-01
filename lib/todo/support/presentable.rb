# frozen_string_literal: true

module Todo
  module Support
    module Presentable
      def presenter
        "Todo::Presenters::#{self.class.name.demodulize}Presenter".constantize.new(self, options: options)
      end
    end
  end
end
