# frozen_string_literal: true

module Kagu
  module Models
    module Extensions
      module Searchable
        extend ActiveSupport::Concern

        included do |other|
          other.class_exec(
            Kagu::Search::ActiveModelMapper.new(other)
          ) do |configurator|

            include Elasticsearch::Model

            @elasticsearch_mapper = configurator

            class << self
              extend Forwardable
              def_delegators :@elasticsearch_mapper,
                             :fields,
                             :searchable

              attr_reader :elasticsearch_mapper
            end
          end
        end
      end
    end
  end
end
