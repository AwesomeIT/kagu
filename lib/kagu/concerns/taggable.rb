module Kagu
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do |other|
        relation_name = 
          other.name.demodulize.underscore.pluralize.to_sym

        Models::Tag.taggable_kinds << relation_name

        other.class_eval do
          has_many :tags, as: :kindable, through: :tag_mappings
          has_many :tag_mappings, as: :kindable
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