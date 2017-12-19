require 'test_helper'

class Api::V1::LocationsControllerTest < ActionDispatch::IntegrationTest
  test "POST /api/v1/code_schools/:code_school_id/locations" do
    school = create(:code_school)
    params = {
      location: {
        va_accepted: Faker::Boolean.boolean,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }

    post api_v1_code_school_locations_path(school, params)
    assert_response :success
  end

  test "PATCH /api/v1/code_schools/:code_school_id/locations/:id" do
    school = create(:code_school)
    location = create(:location)
    params = {
      location: {
        va_accepted: Faker::Boolean.boolean,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }
    patch api_v1_code_school_location_path(school, location, params: params)
    assert_response :success
  end

  test "DELETE /api/v1/code_schools/:code_school_id/locations/:id" do
    school = create(:code_school)
    location = create(:location)
    delete api_v1_code_school_location_path(school, location)
    assert_response :success
  end
end
