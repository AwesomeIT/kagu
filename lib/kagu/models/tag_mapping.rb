# frozen_string_literal: true
module Kagu
  module Models
    class TagMapping < ApplicationRecord
      belongs_to :tag
      belongs_to :kindable, polymorphic: true
    end
  end
end
