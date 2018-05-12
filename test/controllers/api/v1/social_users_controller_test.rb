require 'test_helper'

class Api::V1::SocialUsersControllerTest < ActionDispatch::IntegrationTest
  test 'show returns /profile if the user is already registered' do
    bob = create(:user, first_name: 'Bob', last_name: 'Belcher', email: 'bobs@burgers.com', zip: '62149', password: 'Archer' )
    params = { params: { email: 'bobs@burgers.com'} }

    get api_v1_social_users_url(params), as: :json
    json = response.parsed_body

    assert_equal '/login', json['redirect_to']
  end

  test 'show returns /social_login if the user is not registered' do
    params = { params: { email: 'bobs@burgers.com'} }

    get api_v1_social_users_url(params), as: :json
    json = response.parsed_body

    assert_equal '/social_login', json['redirect_to']
  end

  test 'create returns token, user and redirect path /profile when the user is already registered' do
    james = create(:user, first_name: 'James', last_name: 'Kirk', email: 'kirk@starfleet.gov', zip: '13124', password: 'XOSpock' )
    params = { user: { first_name: 'James',last_name: 'Kirk',email: 'kirk@starfleet.gov',zip: '13124',password: 'XOSpock'} }

    post api_v1_social_users_url, params: params, as: :json
    json = response.parsed_body

    assert_equal '/profile', json['redirect_to']
    assert_equal params[:user][:first_name], json['user']['first_name']
    assert_equal params[:user][:last_name], json['user']['last_name']
    assert_equal params[:user][:email], json['user']['email']
    assert_equal params[:user][:zip], json['user']['zip']
    refute_nil json['token']
  end

  test 'create returns token, user and redirect path /social-login when the user is not registered' do
    params = { user: { first_name: 'Jean Luc',last_name: 'Picard',email: 'picard@tng.com',zip: '41153',password: 'Engage'} }

    post api_v1_social_users_url, params: params, as: :json
    json = response.parsed_body
    
    assert_equal '/signup-info', json['redirect_to']
    assert_equal params[:user][:first_name], json['user']['first_name']
    assert_equal params[:user][:last_name], json['user']['last_name']
    assert_equal params[:user][:email], json['user']['email']
    assert_equal params[:user][:zip], json['user']['zip']
    refute_nil json['token']
  end
end
