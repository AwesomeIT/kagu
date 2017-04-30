# frozen_string_literal: true
module Kagu
  module Models
    class Experiment < ApplicationRecord
      include Tags::Taggable

      belongs_to :user
      has_many :scores
      has_and_belongs_to_many :samples

      has_one :organization_mapping, as: :kindable
      has_one :organization, through: :organization_mapping, dependent: :destroy
    end
  end
end
