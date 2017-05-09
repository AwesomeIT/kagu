# frozen_string_literal: true

module Kagu
  module Models
    extend ActiveSupport::Autoload

    autoload :Extensions

    autoload :ApplicationRecord
    autoload :Experiment
    autoload :Organization
    autoload :OrganizationMapping
    autoload :Role
    autoload :Sample
    autoload :Score
    autoload :Tag
    autoload :TagMapping
    autoload :User
  end
end
