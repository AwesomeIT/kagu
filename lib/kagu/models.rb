module Kagu
  module Models
    extend ActiveSupport::Autoload

    autoload :ApplicationRecord
    autoload :Install
    autoload :User
    autoload :Sample
    autoload :Experiment
    autoload :Score
  end
end