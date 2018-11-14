require 'test_helper'

class AddUserToSendGridJobTest < ActiveSupport::TestCase
  test 'it adds a user to send grid' do
    job = AddUserToSendGridJob.new
    user = FactoryGirl.create(:user)

    SendGridClient.any_instance.expects(:add_user).with(user)

    job.perform(user.id)
  end
end
