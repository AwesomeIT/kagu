# frozen_string_literal: true
module Kagu
  module Models
    class Organization < ApplicationRecord
      include Extensions::Taggable
      include Extensions::Searchable

      searchable do
        attributes :name
        derived :tags, :tag_strings, :string
      end

      has_many :organization_mappings

      has_many :users,
               through: :organization_mappings,
               source: :kindable,
               source_type: User.name

      has_many :experiments,
               through: :organization_mappings,
               source: :kindable,
               source_type: Experiment.name

      has_many :samples,
               through: :organization_mappings,
               source: :kindable,
               source_type: Sample.name

      alias_attribute :resources, :kindable
    end
  end
end
