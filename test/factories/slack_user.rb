FactoryGirl.define do
  factory :slack_user do
    slack_id { ['U', 'W'].sample + Faker::Lorem.characters(10) }
    slack_name { Faker::Name.name }
    slack_real_name { Faker::Name.name }
    slack_display_name { Faker::Internet.user_name }
    slack_email { Faker::Internet.email }
    user_id { association(:user) || User.last.id }
  end
end
