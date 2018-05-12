require 'test_helper'

class ClientTest < Minitest::Test
  def test_get_records_for_gets_all_the_records_for_the_passed_table
    VCR.use_cassette('airtable/client/get_records_successful') do
      response = Airtable::Client.new.get_records_for('Services')

      assert response['records'].present?
    end
  end

  def test_post_record_creates_a_new_record_in_the_passed_table
    request_body = {
      'fields' => {
        'Slack User' => 'test_case_1',
        'Service' => [
          'rec3ZQMCQsKPKlE2C'
        ],
        'Skillsets' => [
          'Java'
        ],
        'Additional Details' => 'Some test description.',
        'Mentor Requested' => [
          'rec0SDZDK2DiW4PY9'
        ]
      }
    }.to_json

    VCR.use_cassette('airtable/client/post_record_successful') do
      response = Airtable::Client.new.post_record('Mentor Request', request_body)

      assert response['id'].present?
      assert response['createdTime'].present?
    end
  end
end
