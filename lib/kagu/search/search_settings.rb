# frozen_string_literal: true
module Kagu
  module Search
    module SearchSettings
      # elasticsearch-model does not like immutable Hashes
      NGRAM_QUERY = lambda do |field, input|
        { query: { match: { field => {
          query: input
        } } } }
      end
      # rubocop:enable Style/MutableConstant
    end
  end
end
