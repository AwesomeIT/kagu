# frozen_string_literal: true

module Kagu
  module Events
    class Base < Karafka::BaseResponder
      def self.call(*data)
        new.call(*data)
      end

      def call(*data)
        respond(*data)
        validate!
        deliver! unless Rails.env.test?
      end

      def respond(*_args)
        raise NotImplementedError
      end

      private

      def model_base_message(model)
        @model_base_message ||= {
          type: model.class.name,
          id: model.id
        }
      end
    end
  end
end
