# frozen_string_literal: true
require 'pry'

module Kagu
  module Search
    class ActiveModelMapper
      def initialize(klass)
        @klass = klass
        @fields = {}
      end

      def attributes(*args)
        zipped = args.map(&:to_s)
                     .zip(Array.new(args.length, _mapper_type: :attribute))
        fields.merge!(Hash[zipped])
      end

      def derived_as_json(instance)
        Hash[fields.select { |_, v| v.key?(:getter) }
                   .map    { |k, v| [k, instance.send(v[:getter])] }]
      end

      def derived(fname, data_method, type)
        fields[fname.to_s] = {
          getter: data_method, type: type, _mapper_type: :derived
        }
      end

      def searchable(&block)
        instance_eval(&block)
        configure
      end

      private

      attr_reader :fields, :klass

      def configure
        klass.class_exec(mapped_fields) do |config|
          settings Kagu::Search::IndexSettings::BASE_INDEX do
            mappings dynamic: 'false' do
              config.each_pair { |i, a| indexes i, a }
            end
          end
        end

        klass.send(:define_method, :as_indexed_json) do
          as_json.merge(
            self.class.elasticsearch_mapper.serializable_relations(self)
          )
        end
      end

      def mapped_fields
        @map_fields ||= begin
          mapped = fields.map do |fname, settings|
            type = store_adapter.send(
              "#{settings[:_mapper_type]}_type", klass, fname, settings
            )

            raise Exceptions::MissingTypeSetting, 'No mapping settings defined'\
              " for type #{type}!" unless type_settings.key?(type)

            elastic_settings = { type: type }.merge(type_settings[type])
            [fname, elastic_settings]
          end
          Hash[mapped]
        end
      end

      def store_adapter
        @store_adapter ||=
          if klass < ActiveRecord::Base
            StoreAdapters::ActiveRecord
          else
            raise Exceptions::MissingStoreAdapter, 'You must define a '\
              "StoreAdapter for your ORM for #{klass.superclass.name}."
          end
      end

      def type_settings
        @type_settings ||= {
          string: { analyzer: 'edge_ngram_analyzer' }
        }.with_indifferent_access
      end
    end
  end
end
