require 'test_helper'

class Api::V1::Airtable::MentorshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user, :verified)
    @headers = authorization_headers(user)
  end

  test ':index renders mentorship data' do
    VCR.use_cassette('airtable/mentorship/successful') do
      get api_v1_airtable_mentorships_path, headers: @headers, as: :json

      assert_equal 200, response.status
      assert_equal ['mentors', 'services', 'skillsets'], response.parsed_body.keys.sort
    end
  end

  test ':index when rate limit returns a 422 and error message' do
    VCR.use_cassette('airtable/mentorship/exceeded_rate_limit') do
      get api_v1_airtable_mentorships_path, headers: @headers, as: :json

      assert_equal 422, response.status
      assert response.parsed_body['error'].present?
    end
  end

  test ':create creates a new mentor request record in Airtable' do
    VCR.use_cassette('airtable/mentorship/post_successful') do
      params = {
        slack_user: 'test_case_1',
        email: 'test@example.com',
        services: 'rec3ZQMCQsKPKlE2C',
        skillsets: 'Java',
        additional_details: 'Some test description.',
        mentor_requested: 'rec0SDZDK2DiW4PY9'
      }

      post(
        api_v1_airtable_mentorships_url,
        params: params,
        headers: @headers,
        as: :json
      )

      assert_equal 201, response.status
      assert response.parsed_body['id'].present?
      assert response.parsed_body['createdTime'].present?
    end
  end

  test ':create with multiple skillets creates a new mentor request record in Airtable' do
    VCR.use_cassette('airtable/mentorship/post_multiple_successful') do
      params = {
        slack_user: 'test_case_1',
        email: 'test@example.com',
        services: 'rec891lUSSaXM4qGC',
        skillsets: 'Java, Study Help, Web Development (Front-end)',
        additional_details: 'Some test description.',
        mentor_requested: 'recqeVhDDJU5cY8TX'
      }

      post(
        api_v1_airtable_mentorships_url,
        params: params,
        headers: @headers,
        as: :json
      )

      assert_equal 201, response.status
      assert response.parsed_body['id'].present?
      assert response.parsed_body['createdTime'].present?
    end
  end
end
