# frozen_string_literal: true
module Kagu
  module Search
    module IndexSettings
      # elasticsearch-model does not like immutable Hashes
      # rubocop:disable Style/MutableConstant
      BASE_INDEX = { analysis: {
        filter: {
          edge_ngram_filter: {
            type: 'edgeNGram',
            min_gram: '2',
            max_gram: '10',
            token_chars: %w(letter digit symbol)
          }
        },
        analyzer: {
          edge_ngram_analyzer: {
            type: 'custom',
            tokenizer: 'standard',
            filter: %w(lowercase edge_ngram_filter)
          }
        }
      } }
      # rubocop:enable Style/MutableConstant
    end
  end
end
