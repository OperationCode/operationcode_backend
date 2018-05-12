FactoryGirl.define do
  factory :team_member do
    name 'John Smith'
    role 'Board Advisor'
    group TeamMember::BOARD_GROUP_NAME
    description 'Long and wonderful history of employment'
    image_src 'images/john_smith.jpg'
  end

  trait :board do
    group TeamMember::BOARD_GROUP_NAME
  end

  trait :executive do
    group TeamMember::EXECUTIVE_GROUP_NAME
  end

  trait :team do
    group TeamMember::TEAM_GROUP_NAME
  end
end
