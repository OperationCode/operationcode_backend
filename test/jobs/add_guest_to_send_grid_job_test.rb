require 'test_helper'

class AddGuestToSendGridJobTest < ActiveJob::TestCase
  test 'it adds the guest to send grid' do
    guest = SendGridClient::Guest.user(valid_email)

    SendGridClient.any_instance.expects(:add_user).with(guest)

    AddGuestToSendGridJob.perform_now(valid_email)
  end
end

def valid_email
  'john@gmail.com'
end
