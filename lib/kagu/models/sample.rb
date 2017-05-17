# frozen_string_literal: true

module Kagu
  module Models
    class Sample < ApplicationRecord
      include Extensions::Taggable
      include Extensions::Searchable

      def private_url
        return if s3_key.blank? || ENV.fetch('RAILS_ENV', '')
                                      .include?('test')

        Kagu::Adapters::S3.object_by_key(s3_key)
                          .presigned_url(:get, expires_in: 3600)
      end

      searchable do
        attributes :name
        derived :tags, :tag_strings, :string
      end

      belongs_to :user
      has_many :scores
      has_and_belongs_to_many :experiments

      has_many :organization_mappings, as: :kindable,
                                       foreign_key: :kindable_id

      has_many :organizations, through: :organization_mappings
    end
  end
end
