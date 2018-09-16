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
    mooc false
    is_partner false
    rep_name Faker::Name.name
    rep_email Faker::Internet.email

    factory :code_school_with_locations do
      transient do
        locations_count { rand(1..15) }
      end

      after :create do |code_school, evaluator|
        create_list(:location, evaluator.locations_count, code_school: code_school)
      end
    end
  end
end
