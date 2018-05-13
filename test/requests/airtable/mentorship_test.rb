require 'test_helper'

class MentorshipTest < Minitest::Test
  def setup
    VCR.use_cassette('airtable/mentorship/successful') do
      @successful_response = Airtable::Mentorship.new.mentor_request_data
    end
  end

  def test_mentor_request_data_returns_correct_keys
    assert @successful_response.keys.sort == %i[mentors services skillsets]
  end

  def test_mentor_request_data_returns_correct_mentor_data
    mentor = @successful_response[:mentors].first

    assert mentor[:id].present?
    assert mentor[:name].present?
  end

  def test_mentor_request_data_returns_correct_service_data
    service = @successful_response[:services].first

    assert service[:id].present?
    assert service[:name].present?
  end

  def test_mentor_request_data_returns_correct_skillset_data
    skillset = @successful_response[:skillsets].first

    assert skillset[:id].present?
    assert skillset[:name].present?
  end

  def test_429_raises_airtable_error
    VCR.use_cassette('airtable/mentorship/exceeded_rate_limit') do
      assert_raises Airtable::Error do
        Airtable::Mentorship.new.mentor_request_data
      end
    end
  end

  def test_create_mentor_request_creates_the_passed_mentor_request
    VCR.use_cassette('airtable/mentorship/post_successful') do
      request_body = {
        slack_user: 'test_case_1',
        services: 'rec3ZQMCQsKPKlE2C',
        skillsets: 'Java',
        additional_details: 'Some test description.',
        mentor_requested: 'rec0SDZDK2DiW4PY9'
      }

      response = Airtable::Mentorship.new.create_mentor_request(request_body)

      assert response['id'].present?
      assert response.dig('fields', 'Slack User') == request_body[:slack_user]
      assert response.dig('fields', 'Service') == [request_body[:services]]
      assert response.dig('fields', 'Skillsets') == [request_body[:skillsets]]
      assert response.dig('fields', 'Additional Details') == request_body[:additional_details]
      assert response.dig('fields', 'Mentor Requested') == [request_body[:mentor_requested]]
    end
  end

  def test_format_for_posting_converts_comma_separated_string_into_array_of_strings
    instance = Airtable::Mentorship.new

    converted = instance.send(:format_for_posting, 'this , and long ')
    assert converted == ['this', 'and long']

    converted = instance.send(:format_for_posting, 'this,that')
    assert converted == ['this', 'that']

    converted = instance.send(:format_for_posting, 'this')
    assert converted == ['this']
  end
end
