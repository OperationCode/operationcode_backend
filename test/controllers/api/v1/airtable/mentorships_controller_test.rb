require 'test_helper'

class Api::V1::Airtable::MentorshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
  end

  test ':index renders mentorship data' do
    VCR.use_cassette('airtable/mentorship/successful') do
      get api_v1_airtable_mentorships_path, headers: @headers, as: :json

      assert response.status == 200
      assert response.parsed_body.keys.sort == ['mentors', 'services', 'skillsets']
    end
  end

  test ':index when rate limit returns a 422 and error message' do
    VCR.use_cassette('airtable/mentorship/exceeded_rate_limit') do
      get api_v1_airtable_mentorships_path, headers: @headers, as: :json

      assert response.status == 422
      assert response.parsed_body['error'].present?
    end
  end
end
