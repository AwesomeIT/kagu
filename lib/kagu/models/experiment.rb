# frozen_string_literal: true
module Kagu
  module Models
    class Experiment < ApplicationRecord
      include Elasticsearch::Model
      include Concerns::Taggable

      belongs_to :user
      has_many :scores
      has_and_belongs_to_many :samples
    end
  end
end
