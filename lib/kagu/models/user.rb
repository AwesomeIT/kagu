# frozen_string_literal: true
require 'devise'

module Kagu
  module Models
    class User < ApplicationRecord
      extend Devise::Models
      include Elasticsearch::Model

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
      has_many :tags, polymorphic: true

      has_and_belongs_to_many :roles

      def has_role?(name)
        !!roles.find_by('lower(name) = ?', name.downcase)
      end
    end
  end
end
