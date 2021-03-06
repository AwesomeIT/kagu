# frozen_string_literal: true

module Kagu
  module Models
    class Experiment < ApplicationRecord
      include Extensions::Taggable
      include Extensions::Searchable

      searchable do
        attributes :name
        derived :tags, :tag_strings, :string
      end

      belongs_to :user

      has_many :scores
      has_and_belongs_to_many :samples

      has_one :organization_mapping, as: :kindable, foreign_key: :kindable_id
      has_one :organization, through: :organization_mapping, dependent: :destroy
    end
  end
end
