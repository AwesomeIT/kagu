require 'active_support'
require 'active_record'

module Kagu
  extend ActiveSupport::Autoload

  autoload :Bootstrap
  autoload :Models

  Bootstrap.bootstrap
end