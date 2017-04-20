# frozen_string_literal: true
module Kagu
  module Models
    extend ActiveSupport::Autoload

    autoload :ApplicationRecord
    autoload :Experiment
    autoload :Role
    autoload :Sample
    autoload :Score
    autoload :Tag
    autoload :User
  end
end
