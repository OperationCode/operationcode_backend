FactoryGirl.define do
  factory :event do
    trait :updated_in_the_future do
        source_updated {2.days.from_now}
    end

    trait :updated_today do
        source_updated { Date.today }
    end
    name "MyEvent"
    description "A fun meetup"
    url "http://www.foobar.com"
    start_date "2017-06-12 21:24:05"
    end_date "2017-06-12 24:24:05"
    address1 "1234 Coding Way"
    address2 "Building 4" 
    city "Norfolk"
    source "Meetup"
    source_id "1232434"
  end
end
