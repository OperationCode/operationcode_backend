require 'test_helper'

class Api::V1::MentorsControllerTest < ActionDispatch::IntegrationTest

  test 'users can get list of mentors' do
    skip
    user = create(:user)
    headers = authorization_headers(user)
    create_list(:mentor, 2)
    get api_v1_mentors_url, headers: headers, as: :json
    assert_equal 2, response.parsed_body.count
  end

  test 'users can show a mentor' do
    user = create(:user)
    headers = authorization_headers(user)
    mentor = create(:mentor)

    get api_v1_mentor_url(mentor), headers: headers, as: :json
    assert_equal mentor.bio, response.parsed_body['bio']
  end

end
