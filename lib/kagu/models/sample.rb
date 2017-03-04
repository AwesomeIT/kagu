# frozen_string_literal: true
module Kagu
  module Models
    class Sample < ApplicationRecord
      belongs_to :user
      has_and_belongs_to_many :experiment
    end
  end
end
