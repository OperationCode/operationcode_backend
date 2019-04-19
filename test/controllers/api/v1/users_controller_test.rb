require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test ':index returns User.count' do
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

  def valid_user_params
    {
      email: 'test@example.com',
      first_name: 'new first name',
      password: 'Password',
      zip: '97201'
    }
  end

  test '#create returns error with missing zip code' do
    post api_v1_users_url,
      params: {
        user: valid_user_params.merge(zip: '')
      },
      as: :json

    body = JSON.parse(response.body)
    assert body['zip'] == ["can't be blank"]
  end

  test '#create is successful with valid zip code' do
    post api_v1_users_url,
      params: { user: valid_user_params },
      as: :json

    user = User.first
    assert_response :success
    assert valid_user_params[:email], user.email
    assert valid_user_params[:first_name], user.first_name
    assert valid_user_params[:password], user.password
    assert valid_user_params[:zip], user.zip
  end

  test '#create calls add_to_send_grid job queue addition' do
    User.any_instance.expects(:add_to_send_grid)
    post api_v1_users_url,
      params: { user: valid_user_params },
      as: :json
  end

  test '#create calls invite_to_slack job queue addition' do
    User.any_instance.expects(:invite_to_slack)
    post api_v1_users_url,
      params: { user: valid_user_params },
      as: :json
  end

  test '#by_email returns success when user exists' do
    tom = create(:user)
    params = { email: tom.email }
    get api_v1_users_by_email_path(params), as: :json
    assert_equal({ 'status' => 'ok' }, response.parsed_body)
    assert_equal 200, response.status
  end

  test '#by_email returns failure user when doesn\'t exist' do
    params = { email: 'fake_email@gmail.com' }
    get api_v1_users_by_email_url(params), as: :json
    assert_equal({ 'status' => 'not_found'}, response.parsed_body)
    assert_equal 404, response.status
  end

  test '#me requires auth token to get valid response' do
    user_good = create(:user)
    user_bad = create(:user)
    headers_good = authorization_headers(user_good)
    headers_bad = authorization_headers(user_bad)
    user_good.valid?
    debugger user_good.errors.messages
    get api_v1_users_me_url, params: { email: user_bad.email }, headers: headers_good , as: :json
    assert_equal 422, response.status

  end

  # test '#me with valid auth token returns success' do
  #   user = create(:user)
  #   headers = authorization_headers(user)
  #   post api_v1_users_me_url, params: { email: user.email }, headers: headers, as: :json
  #   assert_equal 200, response.status
  # end

  test ':by_location returns User.count of users located in the passed in location' do
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
