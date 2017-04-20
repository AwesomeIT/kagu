# frozen_string_literal: true
module Kagu
  module Models
    class Experiment < ApplicationRecord
      include Elasticsearch::Model

      belongs_to :user
      has_many :scores
      has_many :tags, as: :kindable
      has_and_belongs_to_many :samples
    end
  end
end
