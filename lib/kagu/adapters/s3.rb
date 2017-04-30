# frozen_string_literal: true
require 'aws-sdk'

module Kagu
  module Adapters
    class S3
      include Singleton

      class << self
        extend Forwardable
        def_delegators :instance, :file_to_buffer, :upload_file
      end

      def file_to_buffer(s3_url)
        object_output = bucket.object(s3_url).get
        object_output.body if object_output.present?
      end

      def upload_file(path, file_name)
        obj = bucket.object(file_name)
        obj.upload_file(path)
        obj.public_url
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
