require 'test_helper'

class Api::V1::SlackUsersControllerTest < ActionDispatch::IntegrationTest
  test ':access confirms the passed token is equal to the secrets.py_bot_auth_key' do
    token = JsonWebToken.encode({ key: Rails.application.secrets.py_bot_auth_key })

    get access_api_v1_slack_users_url,
      headers: auth_headers(token),
      as: :json

    body = JSON.parse(response.body)

    assert response.status == 200
    assert body == { 'message' => 'You have access!' }
  end

  test ':access returns a 401 with an incorrect token' do
    invalid_token = JsonWebToken.encode({ key: 'an invalid token' })

    get access_api_v1_slack_users_url,
      headers: auth_headers(invalid_token),
      as: :json

    body = JSON.parse(response.body)

    assert response.status == 401
    assert body == { 'errors' => ['Auth token is invalid'] }
  end

  test ':access returns a 401 with an expired token' do
    expired_token = JsonWebToken.encode({ key: 'an expired token' }, 0)

    get access_api_v1_slack_users_url,
      headers: auth_headers(expired_token),
      as: :json

    body = JSON.parse(response.body)

    assert response.status == 401
    assert body == { 'errors' => ['Auth token has expired'] }
  end

  test ':access returns a 401 with a malformed token' do
    malformed_token = 'a malformed token'

    get access_api_v1_slack_users_url,
      headers: auth_headers(malformed_token),
      as: :json

    body = JSON.parse(response.body)

    assert response.status == 401
    assert body == { 'errors' => ['Invalid auth token'] }
  end
end

def auth_headers(token)
  { 'Authorization': "bearer #{token}" }
end
