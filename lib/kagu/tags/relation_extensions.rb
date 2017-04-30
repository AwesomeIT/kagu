# frozen_string_literal: true
module Kagu
  module Tags
    module RelationExtensions
      extend ActiveSupport::Concern

      included do |model|
        model.class_eval do
          has_many :tags, as: :kindable, through: :tag_mappings do
            def <<(other)
              super(Array.wrap(other).inject([]) do |m, t|
                tag = Tag.find_or_create_by(name: t.downcase.strip)
                next m if include?(tag)
                m << tag
              end)
            end

            def >>(other)
              delete(Array.wrap(other).inject([]) do |m, t|
                tag = Tag.find_or_create_by(name: t.downcase.strip)
                next m unless include?(tag)
                m << tag
              end)
            end
          end

          has_many :tag_mappings, as: :kindable
        end
      end
    end
  end
end
