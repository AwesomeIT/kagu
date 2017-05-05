# frozen_string_literal: true
module Kagu
  module Search
    extend ActiveSupport::Autoload

    autoload :ActiveModelMapper
    autoload :Exceptions
    autoload :IndexSettings
    autoload :StoreAdapters
  end
end
