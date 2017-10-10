require 'test_helper'

class SendGridClientTest < ActiveSupport::TestCase
  test 'it adds a user to sendgrid' do
    user = FactoryGirl.build(:user)
    mock_sendgrid_client_for(user)
    assert SendGridClient.new.add_user(user)
  end

  # Sendgrid's gem uses a TON of chained methods. This mess is stubbing out all of them
  # while checking to make sure we get sane parameters
  def mock_sendgrid_client_for(user)
    mock_response = mock
    mock_response.expects(:status_code).returns('201').at_least_once
    mock_response.stubs(:body).returns('{ "error_count": 0, "persisted_recipients": [ "1234" ] }')

    mock_recipients = mock
    mock_recipients.expects(:post).with(request_body: ['first_name' => user.first_name, 'last_name' => user.last_name, 'email' => user.email]).returns(mock_response)

    mock_list_response = mock
    mock_list_response.stubs(:status_code).returns('201')
    mock_list_response.stubs(:body).returns(nil)

    mock_list_post = mock
    mock_list_post.stubs(:post).returns(mock_list_response)

    mock_recipient_id = mock
    mock_recipient_id.stubs(:_).with(['1234']).returns(mock_list_post)

    mock_list_id = mock
    mock_list_id.stubs(:recipients).returns(mock_recipient_id)

    mock_lists = mock
    mock_lists.stubs(:_).with(SendGridClient::LIST_ID).returns(mock_list_id)

    mock_contactdb = mock
    mock_contactdb.stubs(:recipients).returns(mock_recipients)
    mock_contactdb.stubs(:lists).returns(mock_lists)

    mock_client = mock
    mock_client.stubs(:contactdb).returns(mock_contactdb)

    SendGrid::API.any_instance.stubs(:client).returns(mock_client)
  end
end
