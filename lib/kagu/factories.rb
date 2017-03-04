# frozen_string_literal: true
require 'factory_girl'

module Kagu
  module Factories
    Dir["#{Kagu.root}/lib/kagu/factories/**/*.rb"].each(&method(:require))
  end
end
