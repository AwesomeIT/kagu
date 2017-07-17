# frozen_string_literal: true

module Kagu
  module Events
    extend ActiveSupport::Autoload

    autoload :Base

    autoload :EsManage
    autoload :PostgresProducer
  end
end
