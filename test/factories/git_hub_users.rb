FactoryGirl.define do
  factory :git_hub_user do
    git_hub_login "oc coder"
    git_hub_id { Faker::Number.number(5).to_i }
  end
end
