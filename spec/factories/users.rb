require 'faker'

FactoryGirl.define do
  factory :user, aliases: [:sender, :recipient, :reviewer, :reviewee] do
      email { Faker::Internet.email }
      password "123456"

      full_name { Faker::Name.first_name + ' ' + Faker::Name.last_name }
      username { Faker::GameOfThrones.character.downcase.gsub(/\s+/, "") }
      mobile_number { Faker::PhoneNumber.cell_phone }

      verified { Faker::Boolean.boolean }
      status :active

      factory :inactive_user do
        status :inactive
      end
  end
end
