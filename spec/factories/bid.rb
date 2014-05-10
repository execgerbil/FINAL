FactoryGirl.define do

  factory :bid do
    association :auction, factory: :auction
    bid_price Faker::Number.number(3)
    is_higher true    
  end

end