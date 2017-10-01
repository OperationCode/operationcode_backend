FactoryGirl.define do
  factory :git_hub_statistic do
    git_hub_user
    sequence(:source_id, 10000) { |n| n.to_s }
    source_type GitHubStatistic::PR
    repository 'operationcode_backend'
    url { Faker::Internet.url }
    title { Faker::Hacker.say_something_smart }
    state 'closed'
    completed_on { Faker::Date.between(5.years.ago, Date.yesterday) }

    trait :commit do
      source_type GitHubStatistic::COMMIT
      state nil
    end

    trait :issue do
      source_type GitHubStatistic::ISSUE
      state 'open'
    end
  end
end
