FactoryGirl.define do
  factory :code_school do
    name Faker::Company.name
    url Faker::Internet.url
    logo Faker::Internet.url
    full_time Faker::Boolean.boolean
    hardware_included Faker::Boolean.boolean
    has_online Faker::Boolean.boolean
    online_only Faker::Boolean.boolean
    notes Faker::Lorem.paragraph
  end
end
