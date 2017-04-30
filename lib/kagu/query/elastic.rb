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
        return klass unless query.present?
        
        query.map { |q, a| klass.send(q, a).records }.reduce(:merge)
      end
    end
  end
end