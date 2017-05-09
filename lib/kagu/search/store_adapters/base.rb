# frozen_string_literal: true

module Kagu
  module Search
    module StoreAdapters
      class Base
        class << self
          def attribute_type(_klass, _aname, _ = nil)
            raise NotImplementedError
          end

          def derived_type(_klass, _name, settings)
            settings[:type]
          end
        end
      end
    end
  end
end
