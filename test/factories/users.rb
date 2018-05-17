FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    zip '97201'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    latitude { Faker::Number.decimal(2, 5) }
    longitude { Faker::Number.decimal(2, 5) }
    password { Faker::Lorem.characters(32) }
    bio { Faker::Company.bs }
    timezone 'EST'
    mentor false
    verified false
    state { Faker::Address.state_abbr }

    factory :mentor do
      mentor true
    end

    trait :dynamic_zip do
      zip { Faker::Address.postcode }
    end

    trait :verified do
      verified true
    end
  end
end
