# frozen_string_literal: true
module Kagu
  module Models
    class Experiment < ApplicationRecord
      belongs_to :user
      has_and_belongs_to_many :sample
      has_many :score
    end
  end
end
