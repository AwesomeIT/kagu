# frozen_string_literal: true

module Kagu
  module Search
    module Exceptions
      class InvalidAttributeError < ArgumentError; end

      class MissingTypeSetting < ArgumentError; end

      class MissingStoreAdapter < ArgumentError; end
    end
  end
end
