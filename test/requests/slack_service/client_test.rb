require 'test_helper'

class ClientTest < Minitest::Test
  def test_invite_success
    VCR.use_cassette('slack_service/client/invite_success') do
      response = SlackService::Client.new.invite('test@example.com')
      assert response['ok'].present?
      json = JSON.parse(response)
      assert_equal true, json['ok']
    end
  end

  def test_invite_failure
    VCR.use_cassette('slack_service/client/invite_failure') do
      assert_raises { SlackService::Client.new.invite('test@example.com') }
    end
  end
end
