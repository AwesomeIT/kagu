module Kagu
  module Models
    class Score < ApplicationRecord
    	belongs_to :user
    	belongs_to :experiment
    	belongs_to :sample
    end
  end
end

