# frozen_string_literal: true

module Kagu
  module Models
    class Role < ApplicationRecord
      has_and_belongs_to_many :users
    end
  end
end
