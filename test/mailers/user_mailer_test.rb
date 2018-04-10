require 'test_helper'

class UserMailerTest < ActiveSupport::TestCase

  test 'renders the subject' do
    new_user = create(:user)
    leader = create(:user)
    mail =  UserMailer.new_user_in_leader_area(leader, new_user).deliver_now
    assert_equal mail.subject, "A new user has joined within 50 miles of you"
  end
end
