FactoryGirl.define do
  factory :service do
    name { Faker::Company.name }
  end
end
