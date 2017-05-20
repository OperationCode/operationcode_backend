require 'test_helper'

class Api::V1::ServicesControllerTest < ActionDispatch::IntegrationTest

  test "should get list of all services" do
    get api_v1_services_url, as: :json
    assert_response :success
  end

end
