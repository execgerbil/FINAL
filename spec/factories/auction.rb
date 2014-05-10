FactoryGirl.define do

  factory :auction do
    title Faker::Company.bs
    details Faker::Lorem.paragraph
  end
end