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

    factory :published_sell_ad do
      status :published
      ad_type :sell
    end

    factory :published_buy_ad do
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
