require 'test_helper'

class UserMailerTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test 'renders the subject' do
    new_user = create(:user)
    leader = create(:user)
    mail = UserMailer.new_user_in_leader_area(leader, new_user).deliver_now
    assert_equal mail.subject, 'A new user has joined within 50 miles of you'
  end

  test 'renders the body' do
    new_user = create(:user)
    leader = create(:user)
    expected = <<~EMAIL_BODY
      #{new_user.name}, has joined. They're located within 50 miles of your chapter!
      Please email them at #{new_user.email} and welcome them, and consider providing info on the next local meetup.
      Let's encourage in-person involvement within Operation Code!
    EMAIL_BODY
    mail = UserMailer.new_user_in_leader_area(leader, new_user).deliver_now
    assert_equal mail.body.to_s, expected
  end

  test 'renders the recipients' do
    new_user = create(:user)
    leader = create(:user)
    mail = UserMailer.new_user_in_leader_area(leader, new_user).deliver_now
    assert_equal mail.to, [leader.email]
  end

  test 'enqueues actionmailer' do
    assert_enqueued_emails 1 do
      new_user = create(:user)
      leader = create(:user)
      UserMailer.new_user_in_leader_area(leader, new_user).deliver_later
    end
  end
end
