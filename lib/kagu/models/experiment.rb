module Kagu
  module Models
    class Experiment < ApplicationRecord
    	belongs_to :user
    end
  end
end

