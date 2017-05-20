require 'test_helper'

class Api::V1::MentorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_mentors_url
    assert_response :success
  end

end
