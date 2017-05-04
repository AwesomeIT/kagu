# frozen_string_literal: true
module Kagu
  module Search
    module Exceptions
      class InvalidAttributeError < ArgumentError; end

      class InvalidRelationError < ArgumentError; end

      class MissingTypeSetting < ArgumentError; end
    end
  end
end
