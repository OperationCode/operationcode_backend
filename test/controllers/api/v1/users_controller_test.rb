require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test ":index returns User.count" do
    2.times { create :user }

    get api_v1_users_url, as: :json

    assert_equal({ 'user_count' => User.count }, response.parsed_body)
    assert_equal 200, response.status
  end

  test 'can update a user' do
    user = create(:user)
    headers = authorization_headers(user)

    refute_equal 'new first name', user.first_name
    patch api_v1_users_url, params: { user: { first_name: 'new first name'} }, headers: headers, as: :json
    user.reload
    assert_equal 'new first name', user.first_name
    assert_response :success
  end

  test ":by_location returns User.count of users located in the passed in location" do
    tom = create :user
    sam = create :user

    tom.update_columns latitude: 30.285648, longitude: -97.742052, zip: '78705', state: 'TX'
    sam.update_columns latitude: 30.312601, longitude: -97.738591, zip: '78756', state: 'TX'

    params = { state: 'TX' }
    get api_v1_users_by_location_url(params), headers: @headers, as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)
    assert_equal 200, response.status

    params = { zip: '78705' }
    get api_v1_users_by_location_url(params), as: :json
    assert_equal({ 'user_count' => 1 }, response.parsed_body)
    assert_equal 200, response.status

    params = { zip: '78705, 78756' }
    get api_v1_users_by_location_url(params), as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)
    assert_equal 200, response.status

    params = { lat_long: [30.285648, -97.742052] }
    get api_v1_users_by_location_url(params), as: :json
    assert_equal({ 'user_count' => 2 }, response.parsed_body)
    assert_equal 200, response.status

    params = { lat_long: [30.285648, -97.742052], radius: 1 }
    get api_v1_users_by_location_url(params), as: :json
    assert_equal({ 'user_count' => 1 }, response.parsed_body)
    assert_equal 200, response.status
  end
end
