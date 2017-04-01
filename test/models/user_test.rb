require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'actions are performed on user create' do
    user_opts = { email: 'create_test@example.com', zip: '11772' }
    user = User.new(user_opts)

    SlackJobs::InviterJob.expects(:perform_later).with(email: user_opts[:email])
    MailchimpInviterJob.expects(:perform_later).with(email: user_opts[:email])
    AddUserToAirtablesJob.expects(:perform_later).with(user)

    assert_difference('User.count') { user.save }
  end

  test 'must have a valid email' do
    refute User.new(email: 'bogusemail').valid?
    assert User.new(email: 'goodemail@example.com').valid?
  end
end
