# frozen_string_literal: true
module Kagu
  module Query
    class Elastic
      class << self
        def for(klass)
          new(klass)
        end
      end

      attr_reader :klass, :last_query

      def initialize(klass)
        @klass = klass
      end

      def search(query)
        query = query.with_indifferent_access
        @last_query = query

        return klass unless valid?(query)

        query.map { |q, a| klass.search(query_map[q].call(a)).records }
             .reduce(:merge)
      end

      private

      def query_map
        @query_map ||= {
          tags: Tags::TAG_QUERY
        }.with_indifferent_access
      end

      def valid?(query)
        query.present? || query_map.keys.include?(*query.keys)
      end
    end
  end
end
