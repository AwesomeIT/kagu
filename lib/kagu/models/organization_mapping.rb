# frozen_string_literal: true

module Kagu
  module Models
    class OrganizationMapping < ApplicationRecord
      belongs_to :organization
      belongs_to :kindable, polymorphic: true
    end
  end
end
