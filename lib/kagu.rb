# frozen_string_literal: true
require 'active_support'
require 'active_record'
require 'elasticsearch/model'

module Kagu
  extend ActiveSupport::Autoload

  autoload :Adapters
  autoload :Bootstrap
  autoload :Models
  autoload :Tags
  autoload :Query
  autoload :Search

  class << self
    def root
      File.dirname __dir__
    end
  end

  Bootstrap.bootstrap
end
