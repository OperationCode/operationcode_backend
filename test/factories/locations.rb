FactoryGirl.define do
  factory :location do
    code_school { association(:code_school) || CodeSchool.last  }
    va_accepted { Faker::Boolean.boolean }
    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip_code }
    provides_housing { [true, false].sample }
  end
end
