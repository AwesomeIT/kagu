# frozen_string_literal: true
module Kagu
  module Models
    extend ActiveSupport::Autoload

    autoload :ApplicationRecord
    autoload :User
    autoload :Sample
    autoload :Experiment
    autoload :Score
  end
end
