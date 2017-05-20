FactoryGirl.define do
  factory :squad do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    association :leader, factory: :mentor
    minimum { Faker::Number.between(1, 5) }
    maximum { Faker::Number.between(5, 10) }
    skill_level { Faker::Lorem.word }
    activities { Faker::Lorem.sentence }
    end_condition { Faker::Lorem.sentence }

    trait(:with_mentors) do
      after(:create) do |squad, evaluator|
        squad.mentors << create_list(:mentor, 2)
      end
    end
  end
end
