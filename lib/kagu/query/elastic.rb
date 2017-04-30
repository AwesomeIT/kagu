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
        @last_query = query
        return klass if query.blank? || !query_map.keys.include?(
          *query.keys.map(&:to_s)
        )
        
        query.map { |q, a| klass.search(query_map[q].call(a)).records }
          .reduce(:merge)
      end

      private

      def query_map
        @query_map ||= {
          tags: Tags::TAG_QUERY
        }.with_indifferent_access
      end
    end
  end
end