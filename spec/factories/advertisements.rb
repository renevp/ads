FactoryGirl.define do
  factory :advertisement do
    title "Dollar sell"
    description "Selling of dollars"
    amount 1

    status :created
    user

    ad_type :sell

    factory :published_advertisement do
      status :published
    end
  end
end
