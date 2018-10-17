require 'test_helper'

class Api::V1::SlackUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    token = JsonWebToken.encode({ key: Rails.application.secrets.py_bot_auth_key })
    @headers = auth_headers(token)

    @slack_user = create(:slack_user, slack_name: 'Slack User')
  end

  test ':access confirms the passed token is equal to the secrets.py_bot_auth_key' do
    get access_api_v1_slack_users_url,
      headers: @headers,
      as: :json

    body = JSON.parse(response.body)

    assert_equal response.status, 200
    assert_equal body, { 'message' => 'You have access!' }
  end

  test ':access returns a 401 with an incorrect token' do
    invalid_token = JsonWebToken.encode({ key: 'an invalid token' })

    get access_api_v1_slack_users_url,
      headers: auth_headers(invalid_token),
      as: :json

    body = JSON.parse(response.body)

    assert_equal response.status, 401
    assert_equal body, { 'errors' => ['Auth token is invalid'] }
  end

  test ':access returns a 401 with an expired token' do
    expired_token = JsonWebToken.encode({ key: 'an expired token' }, 0)

    get access_api_v1_slack_users_url,
      headers: auth_headers(expired_token),
      as: :json

    body = JSON.parse(response.body)

    assert_equal response.status, 401
    assert_equal body, { 'errors' => ['Auth token has expired'] }
  end

  test ':access returns a 401 with a malformed token' do
    malformed_token = 'a malformed token'

    get access_api_v1_slack_users_url,
      headers: auth_headers(malformed_token),
      as: :json

    body = JSON.parse(response.body)

    assert_equal response.status, 401
    assert_equal body, { 'errors' => ['Invalid auth token'] }
  end

  test ':create endpoint creates a new SlackUser with no User Reference' do
    params = {
      slack_id: '23fjiofisfd',
      slack_name: 'Test Slack User',
      slack_real_name: 'The Real Slack User',
      slack_display_name: 'The Real Glitter User',
      slack_email: 'slack@user.com'
    }

    post api_v1_slack_users_url, headers: @headers, params: params, as: :json

    slack_user = SlackUser.last
    assert_equal({ 'action' => 'request_account_verification', 'slack_user' => slack_user.id }, response.parsed_body)
  end

  test ':create endpoint creates a new SlackUser with User reference' do
    slack_email = 'slack@user.com'
    user = create(:user, email: slack_email)
    params = {
      slack_id: '23fjiofisfd',
      slack_name: 'Test Slack User',
      slack_real_name: 'The Real Slack User',
      slack_display_name: 'The Real Glitter User',
      slack_email: slack_email
    }

    post api_v1_slack_users_url, headers: @headers, params: params, as: :json

    slack_user = SlackUser.last
    assert_equal response.status, 201
    assert_equal({ 'action' => 'none', 'slack_user' => slack_user.id }, response.parsed_body)
    assert_equal(slack_user.user_id, user.id)
  end

  test ':update endpoint updates an existing Slack User without User Reference' do
    new_email = 'slack2@user.com'
    params = {
      id: @slack_user.id,
      slack_email: new_email
    }

    put api_v1_slack_user_url(@slack_user.id), headers: @headers, params: params, as: :json

    @slack_user.reload
    assert_equal 201, response.status
    assert_equal({ 'action' => 'request_account_verification', 'slack_user' => @slack_user.id }, response.parsed_body)
    assert_equal @slack_user.slack_email, new_email
  end

  test ':update endpoint updates an existing SlackUser with a User reference with different email' do
    new_email = 'slack2@user.com'
    user = create(:user, email: 'different@email.com')
    @slack_user = create(:slack_user, user_id: user.id)

    params = {
      id: @slack_user.id,
      slack_email: new_email
    }

    put api_v1_slack_user_url(@slack_user.id), headers: @headers, params: params, as: :json

    @slack_user.reload
    assert_equal 201, response.status
    assert_equal({ 'action' => 'request_account_verification', 'slack_user' => @slack_user.id }, response.parsed_body)
    assert_equal @slack_user.slack_email, new_email
    assert_equal @slack_user.user_id, user.id
  end

  test ':update endpoint updates an existing SlackUser with a User reference that has same email' do
    new_email = 'slack2@user.com'
    user = create(:user, email: new_email)
    @slack_user = create(:slack_user, user_id: user.id)

    params = {
      id: @slack_user.id,
      slack_email: new_email
    }

    put api_v1_slack_user_url(@slack_user.id), headers: @headers, params: params, as: :json

    @slack_user.reload
    assert_equal 201, response.status
    assert_equal({ 'action' => 'none', 'slack_user' => @slack_user.id }, response.parsed_body)
    assert_equal @slack_user.slack_email, new_email
    assert_equal @slack_user.user_id, user.id
  end
end

def auth_headers(token)
  { 'Authorization': "bearer #{token}" }
end
