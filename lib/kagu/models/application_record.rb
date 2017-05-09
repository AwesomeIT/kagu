# frozen_string_literal: true

module Kagu
  module Models
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
