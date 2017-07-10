require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
  end

  test ":index returns User.count" do
    2.times { create :user }

    get api_v1_users_url, headers: @headers, as: :json

    assert_equal({ 'user_count' => User.count }, response.parsed_body)
    assert_equal 200, response.status
  end

  test ":by_location returns User.count of users located in the passed in location" do
    create :user, zip: '78705', latitude: 30.285648, longitude: -97.742052
    create :user, zip: '78756', latitude: 30.312601, longitude: -97.738591

    params = { zip: '78705' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 1 }, response.parsed_body)
    assert_equal 200, response.status

    params = { zip: '78705, 78756' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)

    params = { city: 'Austin, TX, US' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)

    params = { lat_long: [30.285648, -97.742052] }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)

    params = { lat_long: [30.285648, -97.742052], radius: 2 }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 1 }, response.parsed_body)
  end
end
