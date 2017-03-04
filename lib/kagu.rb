# frozen_string_literal: true
require 'active_support'
require 'active_record'
require 'pry'

module Kagu
  extend ActiveSupport::Autoload
  autoload :Bootstrap
  autoload :Models

  def self.root
    File.dirname __dir__
  end

  Bootstrap.bootstrap
end
