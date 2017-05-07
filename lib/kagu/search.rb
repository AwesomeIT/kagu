# frozen_string_literal: true
module Kagu
  module Search
    extend ActiveSupport::Autoload

    autoload :ActiveModelMapper
    autoload :Exceptions
    autoload :IndexSettings
    autoload :SearchSettings
    autoload :StoreAdapters
  end
end
