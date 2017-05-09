# frozen_string_literal: true

module Kagu
  module Models
    module Extensions
      module Taggable
        extend ActiveSupport::Concern

        def tag_strings
          tags.pluck(:name).join(' ')
        end

        TAG_EXT_LAMBDA = lambda do |mode, model, m, t|
          tag = Tag.find_or_create_by(name: t.downcase.strip)
          next m if mode && model.include?(tag)
          m << tag
        end

        included do |other|
          relation_name = other.name.demodulize.underscore.pluralize.to_sym
          Models::Tag.taggable_kinds[relation_name] = other

          Models::Tag.class_eval do
            has_many relation_name,
                     through: :tag_mappings,
                     source: :kindable,
                     source_type: other
          end

          other.class_eval do
            has_many :tags, as: :kindable, through: :tag_mappings do
              def <<(other)
                super(Array.wrap(other).inject(
                  [], &Taggable::TAG_EXT_LAMBDA.curry[true, self]
                ))
              end

              def >>(other)
                delete(Array.wrap(other).inject(
                         [], &Taggable::TAG_EXT_LAMBDA.curry[false, self]
                ))
              end
            end

            has_many :tag_mappings, as: :kindable
          end
        end
      end
    end
  end
end
