FactoryGirl.define do
  factory :location do
    va_accepted Faker::Boolean.boolean
    address1 Faker::Address.street_address
    address2 Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state
    zip Faker::Address.zip_code
    code_school nil
  end
end
