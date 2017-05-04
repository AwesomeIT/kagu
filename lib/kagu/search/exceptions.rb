module Kagu
  module Search
    module Exceptions
      class InvalidAttributeError < ArgumentError; end;

      class MissingTypeSetting < ArgumentError; end;
    end
  end
end