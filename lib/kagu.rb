require 'active_support'
require 'active_record'

module Kagu
  extend ActiveSupport::Autoload
  autoload :Models

  VERSION = '0.0.1'
end