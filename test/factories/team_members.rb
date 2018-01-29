FactoryGirl.define do
  factory :team_member do
    name "John Smith"
    role "Board Advisor"
    group "board"
  end

  trait :board do
    group "board"
  end

  trait :team do
    group "team"
  end
end
