require 'test_helper'

class AddUserToSendGridJobTest < ActiveJob::TestCase
  test 'it adds a user to send grid' do
    user = FactoryGirl.build(:user)

    SendGridClient.any_instance.expects(:add_user).with(user)

    AddUserToSendGridJob.perform_now(user)
  end

  test "with a user-like Struct wrapped in an array, it adds the Struct user to send grid" do
    guest = [SendGridClient::Guest.user(valid_email)]

    SendGridClient.any_instance.expects(:add_user).with(guest.first)

    AddUserToSendGridJob.perform_now(guest)
  end
end

def valid_email
  "john@gmail.com"
end
