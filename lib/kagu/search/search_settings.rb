# frozen_string_literal: true
module Kagu
  module Search
    module SearchSettings
      # elasticsearch-model does not like immutable Hashes
      NGRAM_QUERY = lambda do |tag_string|
        { query: { match: { tags: {
          query: tag_string
        } } } }
      end
      # rubocop:enable Style/MutableConstant
    end
  end
end
