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

      has_many :sample
      has_many :experiment
      has_many :score
    end
  end
end
