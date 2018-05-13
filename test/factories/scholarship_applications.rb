FactoryGirl.define do
  factory :scholarship_application do
    reason 'MyText'
    terms_accepted false
    user
  end
end
