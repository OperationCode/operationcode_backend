require 'test_helper'

class Api::V1::RequestsControllerTest < ActionDispatch::IntegrationTest

  test "mentors can see all unclaimed requests" do
    user = create(:mentor)
    request = create(:request)
    request = create(:request, :claimed)
    headers = authorization_headers(user)
    get api_v1_requests_url, headers: headers
    assert_equal 1, response.parsed_body.count
  end

  test "create new requests for current user" do
    user = create(:user)
    headers = authorization_headers(user)
    params = {
      request: {
        details: 'New Request',
        language: 'Javascript',
        service_id: 2
      }
    }

    post api_v1_requests_url, headers: headers, params: params, as: :json

    assert_equal user.id, response.parsed_body['user']['id']
    assert_equal params[:request][:details], response.parsed_body['details']
    assert_equal params[:request][:language], response.parsed_body['language']
    assert_equal params[:request][:service_id], response.parsed_body['service_id']
  end

end
