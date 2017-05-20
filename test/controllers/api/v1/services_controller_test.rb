require 'test_helper'

class Api::V1::ServicesControllerTest < ActionDispatch::IntegrationTest

  test "should get list of all services" do
    user = create(:user)
    headers = authorization_headers(user)
    create_list(:service, 2)
    get api_v1_services_url, headers: headers, as: :json
    assert_equal 2, response.parsed_body.count
  end

end
