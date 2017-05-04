# frozen_string_literal: true
module Kagu
  module Models
    module Extensions
      module Searchable
        extend ActiveSupport::Concern

        included do |other|
          other.class_exec(
            Kagu::Search::ActiveModelConfigurator.new(other)
          ) do |configurator|

            include Elasticsearch::Model

            @elasticsearch_configurator = configurator
            
            class << self
              extend Forwardable
              def_delegators :@elasticsearch_configurator,
                             :fields,
                             :searchable
            end
          end
        end
      end
    end
  end
end
