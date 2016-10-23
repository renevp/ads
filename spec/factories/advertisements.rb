FactoryGirl.define do
  factory :advertisement do
    title "Dollar sell"
    description "Selling of dollars"

    status :created
    user

    ad_type :sell
    price Money.new(5000, "AUD")

    factory :published_advertisement do
      status :published
    end
  end
end
