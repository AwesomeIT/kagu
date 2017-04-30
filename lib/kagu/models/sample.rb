# frozen_string_literal: true
module Kagu
  module Models
    class Sample < ApplicationRecord
      include Tags::Taggable

      belongs_to :user
      has_many :scores
      has_and_belongs_to_many :experiments

      has_many :organization_mappings, as: :kindable
      has_many :organizations, through: :organization_mappings
    end
  end
end
