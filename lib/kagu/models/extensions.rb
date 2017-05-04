# frozen_string_literal: true
module Kagu
  module Models
    module Extensions
      extend ActiveSupport::Autoload

      autoload :Taggable
      autoload :Searchable
    end
  end
end
