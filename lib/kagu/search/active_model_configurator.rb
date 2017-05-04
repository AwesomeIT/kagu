# frozen_string_literal: true
require 'pry'

module Kagu
  module Search
    class ActiveModelConfigurator
      def initialize(klass)
        @klass = klass
      end

      def attributes(*args)
        zipped = args.map(&:to_s)
                     .zip(Array.new(args.length, resolve_from_ar: true))
        fields.merge!(Hash[zipped])
      end

      def serializable_relations(ref)
        Hash[fields.select { |_, v| v.key?(:getter) }
                   .map { |k, v| [k, ref.send(v[:getter])] }]
      end

      def relation(assoc, data_method, type)
        fields[assoc.to_s] = { getter: data_method, type: type }
      end

      def searchable(&block)
        instance_eval(&block)
        configure
      end

      private

      attr_reader :klass

      def attribute_type(aname, _)
        raise Exceptions::InvalidAttributeError, 'No attribute '\
          "#{aname} on #{klass.name}!" unless klass.columns_hash.key?(aname)
        klass.columns_hash[aname].type
      end

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
            self.class.elasticsearch_configurator.serializable_relations(self)
          )
        end
      end

      def fields
        @fields ||= {}
      end

      def mapped_fields
        @map_fields ||= begin
          mapped = fields.map do |fname, settings|
            type = settings[:resolve_from_ar] ? :attribute_type : :relation_type
            type = send(type, fname, settings)

            raise Exceptions::MissingTypeSetting, 'No mapping settings defined'\
              " for type #{type}!" unless type_settings.key?(type)

            elastic_settings = { type: type }.merge(type_settings[type])

            [fname, elastic_settings]
          end
          Hash[mapped]
        end
      end

      def relation_type(rname, settings)
        raise Exceptions::InvalidRelationError, 'No relation '\
          "#{rname} on #{klass.name}!" unless klass.reflections.key?(rname)
        settings[:type]
      end

      def type_settings
        @type_settings ||= {
          string: { analyzer: 'edge_ngram_analyzer' }
        }.with_indifferent_access
      end
    end
  end
end
