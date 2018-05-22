FactoryGirl.define do
  factory :scholarship_application do
    reason 'MyText'
    terms_accepted false
    association :user, factory: :user, verified: true
    association :scholarship, factory: :scholarship
  end
end
