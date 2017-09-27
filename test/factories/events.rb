FactoryGirl.define do
  factory :event do
    trait :updated_in_the_future do
        source_updated {2.days.from_now}
    end

    trait :updated_today do
        source_updated { Date.today }
    end
    name "MyEvent"
    description { Faker::Hacker.say_something_smart }
    url { Faker::Internet.url }
    start_date { Faker::Time.forward(30, :morning) }
    end_date { Faker::Time.forward(30, :morning) }
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }
    city { Faker::Address.city }
    source "Meetup"
    source_id { Faker::Lorem.characters(7) }
  end
end
