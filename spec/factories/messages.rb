FactoryGirl.define do
  factory :message do
    sender 
    recipient
    advertisement
    status :sent
    body "MyMessage"
    title "MyTitle"
  end
end
