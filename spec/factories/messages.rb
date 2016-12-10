FactoryGirl.define do
  factory :message do
    sender :user
    recipient :user
    advertisement :advertisement
    status :sent
    body "MyMessage"
    title "MyTitle"
  end
end
