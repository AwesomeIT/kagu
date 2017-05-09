# frozen_string_literal: true

module Kagu
  module Search
    module StoreAdapters
      class ActiveRecord < Base
        class << self
          def attribute_type(klass, aname, _ = nil)
            raise Exceptions::InvalidAttributeError, 'No attribute '\
              "#{aname} on #{klass.name}!" unless klass.columns_hash.key?(aname)
            klass.columns_hash[aname].type
          end
        end
      end
    end
  end
end
