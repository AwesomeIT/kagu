# frozen_string_literal: true
FactoryGirl.define do
  factory :sample do
    sequence :s3_key do |x|
      "s3sample#{x}"
    end
  end
end
