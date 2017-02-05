require 'singleton'

module Kagu
  class Bootstrap
    include Singleton

    def self.bootstrap
      self.instance.link_activerecord_models
    end

    def link_activerecord_models
      Kagu::Models.constants.each do |klass|
        Object.const_set(klass.to_s, "Kagu::Models::#{klass}")
      end
    end
  end
end