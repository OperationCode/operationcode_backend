require 'test_helper'

class Api::V1::LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
  end

  test 'INVALID :create POST /api/v1/code_schools/:code_school_id/locations' do
    school = create(:code_school)
    params = {
      location: {
        code_school_id: nil,
        va_accepted: Faker::Boolean.boolean,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }

    post api_v1_code_school_locations_path(school, params), headers: @headers

    assert_response :unprocessable_entity
  end

  test 'UNAUTHORIZED :create POST /api/v1/code_schools/:code_school_id/locations' do
    school = create(:code_school)
    params = {
      location: {
        code_school_id: school.id,
        va_accepted: Faker::Boolean.boolean,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }

    post api_v1_code_school_locations_path(school, params)

    assert_response :unauthorized
  end

  test ':create POST /api/v1/code_schools/:code_school_id/locations' do
    school = create(:code_school)
    params = {
      location: {
        code_school_id: school.id,
        va_accepted: Faker::Boolean.boolean,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }

    post api_v1_code_school_locations_path(school, params), headers: @headers

    assert_response :success
  end

  test 'INVALID :update PATCH /api/v1/code_schools/:code_school_id/locations/:id' do
    school = create(:code_school)
    location = create(:location, code_school: school)
    params = {
      location: {
        code_school_id: school.id,
        va_accepted: nil,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }

    patch api_v1_code_school_location_path(school, location, params: params), headers: @headers

    assert_response :unprocessable_entity
  end

  test ':update PATCH /api/v1/code_schools/:code_school_id/locations/:id' do
    school = create(:code_school)
    location = create(:location, code_school: school)
    params = {
      location: {
        code_school_id: school.id,
        va_accepted: Faker::Boolean.boolean,
        address1: Faker::Address.street_address,
        address2: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip_code
      }
    }

    patch api_v1_code_school_location_path(school, location, params: params), headers: @headers

    assert_response :success
  end

  test 'INVALID :destroy DELETE /api/v1/code_schools/:code_school_id/locations/:id' do
    school = create(:code_school)
    location = create(:location, code_school: school)

    delete api_v1_code_school_location_path(school, location.id + 1000), headers: @headers

    assert_response :unprocessable_entity
  end

  test ':destroy DELETE /api/v1/code_schools/:code_school_id/locations/:id' do
    school = create(:code_school)
    location = create(:location, code_school: school)

    delete api_v1_code_school_location_path(school, location), headers: @headers

    assert_response :success
  end
end
