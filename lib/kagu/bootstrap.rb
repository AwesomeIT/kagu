# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'pry'

module Kagu
  class Bootstrap
    include Singleton

    def self.bootstrap
      instance.configure_elasticsearch_client
      instance.test_connection if ENV.key?('KAGU_TEST')
      instance.link_activerecord_models
    end

    def test_connection
      conn_info = YAML.load_file("#{Kagu.root}/db/config.yml")
      ActiveRecord::Base.establish_connection(conn_info['test'])
    end

    def configure_elasticsearch_client
      ::Elasticsearch::Model.client = ::Elasticsearch::Client.new(
        host: ENV.fetch('ELASTICSEARCH_URL', 'localhost:9200'),
        log: true
      )
    end

    def link_activerecord_models
      Kagu::Models.constants.each do |klass|
        const = "Kagu::Models::#{klass}".constantize
        next unless const < ActiveRecord::Base
        Object.const_set(klass.to_s, const)
      end
    end
  end
end
