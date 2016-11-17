FactoryGirl.define do
  factory :advertisement do
    title "Dollar sell"
    description "Selling of dollars"
    status :created
    user
    ad_type :sell
    price Money.new(0, "AUD")
    amount 5

    factory :published_advertisement do
      status :published
    end
  end
end
