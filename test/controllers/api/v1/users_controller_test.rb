require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
  end

  test ":index returns User.count" do
    2.times { create :user }

    get api_v1_users_url, headers: @headers, as: :json

    assert_equal({ 'user_count' => 3 }, response.parsed_body)
    assert_equal 200, response.status
  end

  test ":by_location returns User.count of users located in the passed in location" do
    create :user, zip: '80238', latitude: 39.762920, longitude: -104.872770
    create :user, zip: '80202', latitude: 39.745211, longitude: -104.991638

    assert_equal User.count, 3

    params = { zip: '80238' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 1 }, response.parsed_body)
    assert_equal 200, response.status

    params = { zip: '80238, 80202' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)

    params = { city: 'Denver, CO, US' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)

    params = { coordinates: [39.762920, -104.872770] }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)

    params = { coordinates: [39.762920, -104.872770], radius: 2 }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 1 }, response.parsed_body)
  end
end
