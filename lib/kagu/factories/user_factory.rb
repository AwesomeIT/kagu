# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles { FactoryGirl.create_list(:role, 3) }
    encrypted_password { 'should reallly be bcrypted right now' }
  end

  factory :admin_user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles do
      [Role.find_by(name: 'Administrator') || \
        FactoryGirl.create(:role, name: 'Administrator')]
    end
    encrypted_password { 'should reallly be bcrypted right now' }
  end

  factory :participant_user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles do
      [Role.find_by(name: 'Participant') || \
        FactoryGirl.create(:role, name: 'Participant')]
    end
  end

  factory :researcher_user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles do
      [Role.find_by(name: 'Researcher') || \
        FactoryGirl.create(:role, name: 'Researcher')]
    end
  end
end
# rubocop:enable Metrics/BlockLength
