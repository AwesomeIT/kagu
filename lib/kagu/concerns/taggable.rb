# frozen_string_literal: true
module Kagu
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

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

      included do |other|
        relation_name =
          other.name.demodulize.underscore.pluralize.to_sym

        Models::Tag.taggable_kinds[relation_name] = other

        other.class_eval do
          include Elasticsearch::Model

          has_many :tags, as: :kindable, through: :tag_mappings do
            def <<(records)
              super(Array.wrap(records).inject([]) do |m, t|
                tag = Tag.find_or_create_by(name: t.downcase.strip)
                next m if include?(tag)
                m << tag
              end)
            end
          end

          has_many :tag_mappings, as: :kindable

          settings NGRAM_SETTINGS do
            mappings dynamic: 'false' do
              indexes :tags, type: 'string', analyzer: 'edge_ngram_analyzer'
            end
          end
        end

        Models::Tag.class_eval do
          has_many relation_name,
                   through: :tag_mappings,
                   source: :kindable,
                   source_type: other
        end
      end

      def as_indexed_json(_options = {})
        as_json.merge(tags: tags.pluck(:name))
      end

      class_methods do
        def by_tags(tag_string)
          search(TAG_QUERY.call(tag_string)).records
        end
      end
    end
  end
end
