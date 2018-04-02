require 'test_helper'

class Api::V1::ServicesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user, password: 'pass123')
    @user_params = {
      user: {
        email: @user.email,
        password: 'pass123'
      }
    }
  end

  test 'returns JWT token for succesfull login' do
    post api_v1_sessions_url, params: @user_params, as: :json
    json = response.parsed_body
    byebug
    refute_nil json['token']
  end

  test 'returns user info' do
    post api_v1_sessions_url, params: @user_params, as: :json
    json = response.parsed_body
    assert_equal @user.id, json['user']['id']
    assert_equal @user.first_name, json['user']['first_name']
    assert_equal @user.last_name, json['user']['last_name']
    refute json['user']['mentor']
  end

  test 'it returns a redirect_to path to the users profile for a regular login' do
    post api_v1_sessions_url, params: @user_params, as: :json
    json = response.parsed_body
    assert_equal '/profile', json['redirect_to']
  end

  test 'it returns a redirect_to path to discourse for an sso login' do
    post api_v1_sessions_url, params: @user_params.merge(sso_params), as: :json
    json = response.parsed_body
    assert_match /^https:\/\/community\.operationcode\.org\/session\/sso_login\?sso=.*sig=.*$/, json['redirect_to']
  end

  def discourse_sso_url
    'https://community.operationcode.org?sso=bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGImbmFtZT1M%0AaWxpYW4rUm9tYWd1ZXJhJnVzZXJuYW1lPWFpZGElNDBiZWVyLmluZm8mZW1h%0AaWw9YWlkYSU0MGJlZXIuaW5mbyZyZXF1aXJlX2FjdGl2YXRpb249dHJ1ZSZl%0AeHRlcm5hbF9pZD0yOA%3D%3D%0A&sig=e57b3554b951149981433a63738891892e2da9499125b57ba8084f57cc035de4'
  end

  def sso_params
    {
      sso: 'bm9uY2U9Y2I2ODI1MWVlZmI1MjExZTU4YzAwZmYxMzk1ZjBjMGImbmFtZT1zYW0mdXNlcm5hbWU9c2Ftc2FtJmVtYWlsPXRlc3QlNDB0ZXN0LmNvbSZleHRlcm5hbF9pZD1oZWxsbzEyMyZyZXF1aXJlX2FjdGl2YXRpb249dHJ1ZQ==',
      sig: 'd6bc820029617d00b54f1bb0cf117a91a037b284cbd7d2832c95ef8371062eb1'
    }
  end
end
