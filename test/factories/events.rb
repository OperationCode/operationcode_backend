FactoryGirl.define do
  factory :event do
    name "MyEvent"
    description "A fun meetup"
    url "http://www.foobar.com"
    start_date "2017-06-12 21:24:05"
    end_date "2017-06-12 24:24:05"
    address1 "1234 Coding Way"
    address2 "Building 4" 
    city "Norfolk"
    state "VA"
    zip "23456"
    scholarship_available false
  end
end
