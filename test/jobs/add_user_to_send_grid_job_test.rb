require 'test_helper'

class AddUserToSendGridJobTest < ActiveJob::TestCase
  test 'it adds a user to send grid' do
    user = FactoryGirl.build(:user)

    SendGridClient.any_instance.expects(:add_user).with(user)

    AddUserToSendGridJob.perform_now(user)
  end

  test "with a guest_email, and no user, it adds the Struct user to send grid" do
    guest = SendGridClient::Guest.user(valid_email)

    SendGridClient.any_instance.expects(:add_user).with(guest)

    AddUserToSendGridJob.perform_now(nil, guest_email: valid_email)
  end

  test "with a guest_email, and a valid user, it adds the User to send grid" do
    user = FactoryGirl.build(:user)

    SendGridClient.any_instance.expects(:add_user).with(user)

    AddUserToSendGridJob.perform_now(user, guest_email: valid_email)
  end
end

def valid_email
  "john@gmail.com"
end
