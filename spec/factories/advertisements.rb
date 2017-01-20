require 'faker'

FactoryGirl.define do
  factory :advertisement do
    title "Dollar sell"
    description { Faker::Lorem.sentence }
    status :created
    user
    ad_type :sell
    price { Faker::Commerce.price }
    amount { Faker::Number.between(50, 2000) }

    factory :published_advertisement do
      status :published
    end

    factory :published_sell_ad do
      title "Dollar sell"
      status :published
      ad_type :sell
    end

    factory :published_buy_ad do
      title "Dollar Buy"
      status :published
      ad_type :buy
    end

    factory :created_sell_ad do
      status :created
      ad_type :sell
    end

    factory :created_buy_ad do
      status :created
      ad_type :buy
    end

    factory :closed_sell_ad do
      status :closed
      ad_type :sell
    end

    factory :closed_buy_ad do
      status :closed
      ad_type :buy
    end
  end
end
