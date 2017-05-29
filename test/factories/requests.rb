FactoryGirl.define do

  factory :request do
    user
    association :requested_mentor, factory: :mentor
    details { Faker::Lorem.paragraph }
    language 'Javascript'
    status { ['Unassigned', 'Assigned', 'Contacted', 'Awaiting Response', 'Scheduled', 'Completed'].sample }
    service

    trait :claimed do
      association :assigned_mentor, factory: :mentor
    end
  end

end
