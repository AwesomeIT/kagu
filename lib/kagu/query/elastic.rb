# frozen_string_literal: true
module Kagu
  module Query
    class Elastic
      class << self
        # rubocop:disable Style/Alias
        alias_method :for, :new
        # rubocop:enable Style/Alias
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
          name: Search::SearchSettings::NGRAM_QUERY,
          tags: Search::SearchSettings::NGRAM_QUERY
        }.with_indifferent_access
      end

      def valid?(query)
        query.present? && query.keys.all? { |k| query_map.key?(k) }
      end
    end
  end
end
