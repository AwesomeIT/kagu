# frozen_string_literal: true
module Kagu
  module Models
    module Extensions
      extend ActiveSupport::Autoload

      autoload :Searchable
      autoload :Taggable
    end
  end
end
