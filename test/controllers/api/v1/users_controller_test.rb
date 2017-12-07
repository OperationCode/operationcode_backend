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

  #test "social login can log in a user" do
  #  params = { user: { first_name: 'new first name',last_name: 'new last name',email: 'test@email.com',zip: '12345',password: 'Password'} }
  #  get api_v1_users_by_location_url(params), headers: @headers, as: :json
  #  assert_equal({ 'user_count' => 2 }, response.parsed_body)
  #  assert_equal 200, response.status
  #end

  #test "social login can register and log in a user" do

  #end

  test "exist returns /profile if the user is already registered" do
    params = { user: { email: 'test@email.com'} }
    post api_v1_users_exist, params: params, as: :json
    json = response.parsed_body
    assert_equal '/profile', json['redirect_to']
  end

  test "exist returns /social_login if the user is not registered" do
    params = { user: { email: 'test@email.com'} }
    post api_v1_users_exist, params: params, as: :json
    json = response.parsed_body
    assert_equal '/social_login', json['redirect_to']
  end

  test "social returns token, user and redirect path /profile when the user is already registered" do
    params = { user: { first_name: 'new first name',last_name: 'new last name',email: 'test@email.com',zip: '12345',password: 'Password'} }
    post api_v1_users_social, params: params, as: :json
    json = response.parsed_body
    assert_equal '/profile', json['redirect_to']
    assert_equal @user.id, json['user']['id']
    assert_equal @user.first_name, json['user']['first_name']
    assert_equal @user.last_name, json['user']['last_name']
    refute_nil json['token']
  end

  test "social returns token, user and redirect path /social-login when the user is not registered" do
    params = { user: { first_name: 'new first name',last_name: 'new last name',email: 'test@email.com',zip: '12345',password: 'Password'} }
    post api_v1_users_social, params: params, as: :json
    json = response.parsed_body
    assert_equal '/signup-info', json['redirect_to']
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
