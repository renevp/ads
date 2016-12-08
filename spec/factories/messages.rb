FactoryGirl.define do
  factory :message do
    sender :user
    recipient :user
    advertisement :advertisement
    status :read
    body "MyMessage"
    title "MyTitle"
  end
end
