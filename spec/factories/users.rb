FactoryGirl.define do
  factory :user do
      sequence(:email) { |n| "email#{n}@email.com"}
      password "secretsecret"

      full_name "Rene Vallennilla"
      username "renex"
      mobile_number "045555555"
      verified true
      status :active
  end
end
