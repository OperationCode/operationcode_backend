FactoryGirl.define do
  factory :service do
    name { Faker::Lorem.sentence }
  end
end
