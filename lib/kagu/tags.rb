# frozen_string_literal: true
module Kagu
  module Tags
    extend ActiveSupport::Autoload

    NGRAM_SETTINGS = { analysis: {
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

    TAG_QUERY = lambda do |tag_string|
      {
        query: {
          match: {
            tags: {
              query: tag_string
            }
          }
        }
      }
    end

    autoload :RelationExtensions
    autoload :Taggable
  end
end
