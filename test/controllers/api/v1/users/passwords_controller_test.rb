require 'test_helper'

class Api::V1::Users::PasswordsControllerTest < ActionDispatch::IntegrationTest
  test 'forgot returns successful given an email of an existing user' do
    create :user, email: 'forgetful@example.com'

    post api_v1_users_passwords_forgot_url,
         params: { email: 'forgetful@example.com' },
         as: :json

    assert_equal 200, response.status
  end

  test 'forgot generates a password reset token' do
    user = create :user
    User.any_instance.expects(:generate_password_token!)

    post api_v1_users_passwords_forgot_url,
         params: { email: user.email },
         as: :json
  end

  test 'forgot emails user instructions to reset their password' do
    user = create :user
    User.any_instance.expects(:send_reset_password_instructions)

    post api_v1_users_passwords_forgot_url,
         params: { email: user.email },
         as: :json
  end

  test 'forgot returns unprocessable error when given an email that does not match an existing user' do
    post api_v1_users_passwords_forgot_url,
         params: { email: 'totallydoesnotexist@example.com' },
         as: :json

    assert_equal 422, response.status
  end

  test 'forgot requires an email address be given' do
    post api_v1_users_passwords_forgot_url,
         params: { no: 'email key in params' },
         as: :json
    assert_equal 422, response.status
  end
end
