FactoryGirl.define do
  factory :message do
    sender
    recipient
    advertisement
    status :sent
    body "MyMessage"
    title "MyTitle"

    trait :with_parent do
      after(:build) do |o|
        o.parent = FactoryGirl.create(:message) 
      end
    end
  end
end
