module Kagu
  module Models
    class Sample < ApplicationRecord
    	belongs_to :user
    	has_and_belongs_to_many :experiment
      has_many :score
    end
  end
end

