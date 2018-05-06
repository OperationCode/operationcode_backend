require 'test_helper'

class MentorshipTest < Minitest::Test
  def setup
    VCR.use_cassette('airtable/mentorship/successful') do
      @successful_response = Airtable::Mentorship.new.mentor_request_data
    end
  end

  def test_mentor_request_data_returns_correct_keys
    assert @successful_response.keys.sort == [:mentors, :services, :skillsets]
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
end
