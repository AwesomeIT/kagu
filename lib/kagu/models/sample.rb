# frozen_string_literal: true
module Kagu
  module Models
    class Sample < ApplicationRecord
      include Elasticsearch::Model

      belongs_to :user
      has_many :scores
      has_many :tags, polymorphic: true
      has_and_belongs_to_many :experiments
    end
  end
end
