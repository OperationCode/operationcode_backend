require 'test_helper'

class Api::V1::ServicesControllerTest < ActionDispatch::IntegrationTest

  test "returns JWT token for succesfull login" do
    user = create(:user, password: 'pass123')
    params = {
      user: {
        email: user.email,
        password: 'pass123'
      }
    }
    post api_v1_sessions_url, params: params, as: :json
    json = response.parsed_body
    refute_nil json['token']
  end

  test "returns user info" do
    user = create(:user, password: 'pass123')
    params = {
      user: {
        email: user.email,
        password: 'pass123'
      }
    }
    post api_v1_sessions_url, params: params, as: :json
    json = response.parsed_body
    assert_equal user.id, json['user']['id']
    assert_equal user.first_name, json['user']['first_name']
    assert_equal user.last_name, json['user']['last_name']
    refute json['user']['mentor']
  end
end
