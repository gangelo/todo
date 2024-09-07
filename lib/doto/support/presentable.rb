# frozen_string_literal: true

module Doto
  module Support
    module Presentable
      def presenter
        "Doto::Presenters::#{self.class.name.demodulize}Presenter".constantize.new(self, options: options)
      end
    end
  end
end
