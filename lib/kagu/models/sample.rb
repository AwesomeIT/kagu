module Kagu
  module Models
    class Sample < ApplicationRecord
    	belongs_to :user
    end
  end
end

