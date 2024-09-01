# frozen_string_literal: true

module Todo
  module Migration
    module RawHelpers
      module ColorThemeHash
        def to_h
          read.merge(version: version)
        end
      end
    end
  end
end
