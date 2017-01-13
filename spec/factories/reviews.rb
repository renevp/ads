FactoryGirl.define do
  factory :review do
    reviewer
    reviewee
    rating :positive
    feedback "Good Seller"
  end
end
