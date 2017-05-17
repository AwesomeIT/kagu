# frozen_string_literal: true

require 'devise'

module Kagu
  module Models
    class User < ApplicationRecord
      extend Devise::Models
      include Extensions::Taggable
      include Extensions::Searchable

      searchable do
        derived :tags, :tag_strings, :string
      end

      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable and :omniauthable
      devise :database_authenticatable,
             :recoverable, :rememberable, :trackable, :validatable

      # The access token model is a part of Doorkeeper
      has_many :access_tokens,
               class_name: 'Doorkeeper::AccessToken',
               foreign_key: :resource_owner_id
      has_many :experiments
      has_many :samples
      has_many :scores

      has_and_belongs_to_many :roles

      has_many :organization_mappings, as: :kindable, 
                                       foreign_key: :kindable_id

      has_many :organizations, through: :organization_mappings

      # TODO: rename
      # rubocop:disable Style/PredicateName
      def has_role?(name)
        !roles.find_by('lower(name) = ?', name.downcase).nil?
      end
      # rubocop:enable Style/PredicateName
    end
  end
end
