require 'test_helper'

class Api::V1::RequestsControllerTest < ActionDispatch::IntegrationTest

  test "mentors can see all unclaimed requests" do
    user = create(:mentor)
    headers = authorization_headers(user)
    request = create(:request)
    request = create(:request, :claimed)

    get api_v1_requests_url, headers: headers, as: :json
    assert_equal 1, response.parsed_body.count
  end

  test "users that are not mentors can't see all unclaimed requests" do
    user = create(:user)
    headers = authorization_headers(user)

    get api_v1_requests_url, headers: headers, as: :json
    assert response.status, :forbidden
  end

  test "create new requests for current user" do
    user = create(:user)
    headers = authorization_headers(user)
    service = create(:service)
    params = {
      request: {
        details: 'New Request',
        language: 'Javascript',
        service_id: service.id
      }
    }

    post api_v1_requests_url, headers: headers, params: params, as: :json

    assert_equal user.id, response.parsed_body['user']['id']
    assert_equal service.id, response.parsed_body['service']['id']
    assert_equal params[:request][:details], response.parsed_body['details']
    assert_equal params[:request][:language], response.parsed_body['language']
  end

  test "show individual request" do
    user = create(:mentor)
    headers = authorization_headers(user)
    request = create(:request)

    get api_v1_request_url(id: request.id), headers: headers, as: :json

    assert_equal request.id, response.parsed_body['id']
  end

  test "show error message when unauthorized user tries to view individual request" do
    user = create(:user)
    headers = authorization_headers(user)
    request = create(:request)

    get api_v1_request_url(id: request.id), headers: headers, as: :json

    assert response.status, :forbidden
  end

  test "update individual request" do
    user = create(:user)
    mentor = create(:mentor)
    headers = authorization_headers(mentor)
    request = create(:request)
    status = 'Completed'
    params = { request: { assigned_mentor_id: mentor.id, status: status } }

    put api_v1_request_url(id: request.id), params: params, headers: headers

    request.reload

    assert_equal mentor.id, request.assigned_mentor_id
    assert_equal status, request.status
  end

end
