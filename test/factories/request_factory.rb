FactoryGirl.define do

  factory :request do
    user
    association :requested_mentor, factory: :mentor
    details { Faker::Lorem.paragraph }
    language 'Javascript'
    service

    trait :claimed do
      association :assigned_mentor, factory: :mentor
    end
  end

end
