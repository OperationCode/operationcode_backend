require 'test_helper'

class MentorshipTest < Minitest::Test
  def setup
    VCR.use_cassette('airtable/mentorship/successful') do
      @successful_response = Airtable::Mentorship.new.mentor_request_data
    end
  end

  def test_mentor_request_data_returns_correct_keys
    assert_equal %i[mentors services skillsets], @successful_response.keys.sort
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
        email: 'agreatperson@email.com',
        services: 'rec891lUSSaXM4qGC',
        skillsets: 'Java',
        additional_details: 'Some test description.',
        mentor_requested: 'recqeVhDDJU5cY8TX'
      }

      Slack::Utils.new.stubs(:email_is_registered?).returns(true)

      response = Airtable::Mentorship.new.create_mentor_request(request_body)

      assert response['id'].present?
      assert_equal request_body[:slack_user], response.dig('fields', 'Slack User')
      assert_equal request_body[:email], response.dig('fields', 'Email')
      assert_equal [request_body[:services]], response.dig('fields', 'Service')
      assert_equal [request_body[:skillsets]], response.dig('fields', 'Skillsets')
      assert_equal request_body[:additional_details], response.dig('fields', 'Additional Details')
      assert_equal [request_body[:mentor_requested]], response.dig('fields', 'Mentor Requested')
    end
  end

  def test_format_for_posting_converts_comma_separated_string_into_array_of_strings
    instance = Airtable::Mentorship.new

    converted = instance.send(:format_for_posting, 'this , and long ')
    assert_equal ['this', 'and long'], converted

    converted = instance.send(:format_for_posting, 'this,that')
    assert_equal ['this', 'that'], converted

    converted = instance.send(:format_for_posting, 'this')
    assert_equal ['this'], converted
  end
end
