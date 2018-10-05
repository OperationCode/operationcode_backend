require 'test_helper'

class AddGuestToSendGridJobTest < ActiveSupport::TestCase
  test 'it adds the guest to send grid' do
    job = AddGuestToSendGridJob.new
    guest = SendGridClient::Guest.user(valid_email)

    SendGridClient.any_instance.expects(:add_user).with(guest)

    job.perform(valid_email)
  end
end

def valid_email
  'john@gmail.com'
end
