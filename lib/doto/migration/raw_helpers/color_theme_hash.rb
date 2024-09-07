# frozen_string_literal: true

module Doto
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
