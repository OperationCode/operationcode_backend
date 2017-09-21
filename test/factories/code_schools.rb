FactoryGirl.define do
  factory :code_school do
    name "CoderSchool"
    url "http://www.coderschool.vn"
    logo "https://d388w23p6r1vqc.cloudfront.net/img/startups/11852/logo-1457327647.png"
    full_time false
    hardware_included false
    has_online true
    online_only false
    notes "Amazing place to learn code and explore Vietnam!"
  end
end
