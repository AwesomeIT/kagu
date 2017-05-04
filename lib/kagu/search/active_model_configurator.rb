# frozen_string_literal: true
require 'pry'

module Kagu
  module Search
    class ActiveModelConfigurator
      def initialize(klass)
        @klass = klass
      end

      def fields(*args)
        attributes.push(*args.map(&:to_s))
      end

      def relation(assoc, data_method, type)
        relations[assoc] = { getter: data_method, type: type }
      end

      def searchable(&block)
        self.instance_eval(&block)
        configure
      end

      def serializable_relations
        @serializable_relations ||= relations.map { |k, v| [k, v[:getter]] }
      end

      private

      attr_reader :klass

      def attributes
        @attributes ||= []
      end

      def configure
        klass.class_exec(map_attributes.merge(map_relations)) do |config|
          settings Kagu::Search::IndexSettings::BASE_INDEX do 
            mappings dynamic: 'false' do
              config.each_pair { |i, a| indexes i, a } 
            end
          end
        end

        # klass.send(:define_method, :as_indexed_json) do 
        #   as_json.merge(
        #     @elasticsearch_configurator
        #       .serializable_relations
        #       .map { |k, v| [k, send(v)] }
        #   ) 
        # end
      end

      

      def map_attributes
        @map_attributes ||= attributes.inject({}) do |m, a|
          raise Exceptions::InvalidAttributeError, 'No attribute '\
            "#{a} on #{klass.name}!" unless klass.columns_hash.key?(a)

          type = klass.columns_hash[a].type

          raise Exceptions::MissingTypeSetting, 'No mapping settings defined '\
            "for type #{type}!" unless type_settings.key?(type)

          m[a] = type_settings[type].merge(type: type)
          m
        end
      end

      def map_relations
        @map_relations ||= relations
          .transform_values { |v| v.merge(type_settings[v[:type]]).except(:getter) }
      end

      def relations
        @relations ||= {}
      end

      def type_settings
        @type_settings ||= {
          string: { analyzer: 'edge_ngram_analyzer' }
        }.with_indifferent_access
      end
    end
  end
end
