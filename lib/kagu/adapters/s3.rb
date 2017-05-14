# frozen_string_literal: true

require 'aws-sdk'
require 'securerandom'

module Kagu
  module Adapters
    class S3
      include Singleton

      class << self
        extend Forwardable
        def_delegators :instance,
                       :file_to_buffer, :upload_file, :object_by_key
      end

      def object_by_key(key)
        bucket.object(key)
      end

      def upload_file(path, file_name)
        bucket.object("#{SecureRandom.uuid}.#{file_name.split('.').last}")
              .tap { |o| o.upload_file(path) }
      end

      private

      def bucket
        @bucket ||= resource.bucket(ENV['AWS_S3_BUCKET_NAME'])
      end

      def resource
        @resource ||= ::Aws::S3::Resource.new(
          credentials: ::Aws::Credentials.new(
            ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']
          ),
          region: 'us-east-1'
        )
      end
    end
  end
end
