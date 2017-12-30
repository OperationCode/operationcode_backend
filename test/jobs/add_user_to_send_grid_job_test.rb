require 'test_helper'

class AddUserToSendGridJobTest < ActiveJob::TestCase
  test 'it adds a user to send grid' do
    user = FactoryGirl.build(:user)

    SendGridClient.any_instance.expects(:add_user).with(user)

    AddUserToSendGridJob.perform_now(user)
  end
end
