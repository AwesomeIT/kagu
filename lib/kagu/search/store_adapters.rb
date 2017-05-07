# frozen_string_literal: true
module Kagu
  module Search
    module StoreAdapters
      extend ActiveSupport::Autoload

      autoload :Base
      autoload :ActiveRecord
    end
  end
end
