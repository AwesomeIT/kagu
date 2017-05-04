# frozen_string_literal: true
module Kagu
  module Tags
    module Taggable
      extend ActiveSupport::Concern

      included do |other|
        relation_name =
          other.name.demodulize.underscore.pluralize.to_sym

        Models::Tag.taggable_kinds[relation_name] = other

        other.class_eval do
          include Elasticsearch::Model
          include Tags::RelationExtensions

          settings Tags::NGRAM_SETTINGS do
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
    end
  end
end
