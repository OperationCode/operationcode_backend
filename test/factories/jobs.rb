FactoryGirl.define do
  factory :job do
    title Faker::Lorem.characters(7)
    source_url Faker::Internet.url
    source Faker::Lorem.characters(7)
    city Faker::Address.city
    state Faker::Address.state
    country Faker::Address.country
    description Faker::Lorem.paragraph
    open true
    remote false
  end
end
