require 'test_helper'

class Api::V1::Airtable::MentorshipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user, :verified)
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

  test ':create creates a new mentor request record in Airtable' do
    VCR.use_cassette('airtable/mentorship/post_successful') do
      params = {
        slack_user: 'test_case_1',
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

      assert response.status == 201
      assert response.parsed_body['id'].present?
      assert response.parsed_body['createdTime'].present?
    end
  end

  test ':create with multiple skillets creates a new mentor request record in Airtable' do
    VCR.use_cassette('airtable/mentorship/post_multiple_successful') do
      params = {
        slack_user: 'test_case_1',
        services: 'rec3ZQMCQsKPKlE2C',
        skillsets: 'Java, Study Help, Web (Frontend Development)',
        additional_details: 'Some test description.',
        mentor_requested: 'rec0SDZDK2DiW4PY9'
      }

      post(
        api_v1_airtable_mentorships_url,
        params: params,
        headers: @headers,
        as: :json
      )

      assert response.status == 201
      assert response.parsed_body['id'].present?
      assert response.parsed_body['createdTime'].present?
    end
  end

  test ':create when user is not verified it returns a 422 and error message' do
    user    = create(:user, verified: false)
    headers = authorization_headers(user)

    post(
      api_v1_airtable_mentorships_url,
      params: {},
      headers: headers,
      as: :json
    )

    assert response.status == 422
    assert response.parsed_body['error'].present?
  end
end
