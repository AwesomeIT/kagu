# frozen_string_literal: true

require 'active_support'
require 'active_record'
require 'elasticsearch/model'
require 'karafka'

module Kagu
  extend ActiveSupport::Autoload

  autoload :Adapters
  autoload :Bootstrap
  autoload :Events
  autoload :Models
  autoload :Query
  autoload :Search

  class << self
    def root
      File.dirname __dir__
    end
  end

  Bootstrap.bootstrap
end
