# frozen_string_literal: true
module Kagu
  module Models
    class Tag < ApplicationRecord
      belongs_to :kindable, polymorphic: true
      alias_attribute :tagged, :kindable
    end
  end
end
