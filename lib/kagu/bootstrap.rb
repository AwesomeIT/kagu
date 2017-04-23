# frozen_string_literal: true
require 'singleton'

module Kagu
  class Bootstrap
    include Singleton

    def self.bootstrap
      instance.configure_elasticsearch_client
      instance.link_activerecord_models
    end

    def configure_elasticsearch_client
      ::Elasticsearch::Model.client = ::Elasticsearch::Client.new(
        host: ENV.fetch('ELASTICSEARCH_URL', 'localhost:9200'),
        log: true
      )
    end

    def link_activerecord_models
      Kagu::Models.constants.each do |klass|
        Object.const_set(klass.to_s, "Kagu::Models::#{klass}".constantize)
      end
    end
  end
end
