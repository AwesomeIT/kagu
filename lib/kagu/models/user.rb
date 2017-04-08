# frozen_string_literal: true
require 'devise'

module Kagu
  module Models
    class User < ApplicationRecord
      extend Devise::Models

      # Include default devise modules. Others available are:
      # :confirmable, :lockable, :timeoutable and :omniauthable
      devise :database_authenticatable, :registerable,
             :recoverable, :rememberable, :trackable, :validatable

      # The access token model is a part of Doorkeeper
      has_many :access_tokens
      has_many :experiments
      has_many :samples
      has_many :scores

      has_and_belongs_to_many :roles
    end
  end
end
