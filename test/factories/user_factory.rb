FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    zip { Faker::Address.postcode }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    slack_name { Faker::Lorem.characters(8) }
    latitude { Faker::Number.decimal(2, 5) }
    longitude { Faker::Number.decimal(2, 5) }
    password { Faker::Lorem.characters(32) }
    bio { Faker::Lorem.paragraph }
    timezone 'EST'
    mentor false

    factory :mentor do
      mentor true
    end
  end

end
