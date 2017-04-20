# frozen_string_literal: true
module Kagu
  module Models
    class Tag < ApplicationRecord
      has_many :tag_mappings

      class << self
        def taggable_kinds
          @taggable_kinds ||= []
        end
      end

      alias_attribute :tagged, :kindable
    end
  end
end
