require 'test_helper'

class SendEmailToLeadersJobTest < ActiveJob::TestCase
  test 'send email to leaders if someone signs up within X miles' do
    User.any_instance.stubs(:geocode)
    user = create(:user, email: 'static@email.com', latitude: 40.7, longitude: -73.8)
    leader_user = create(:user, latitude: 40.7001, longitude: -73.8001)
    leader_user.tag_list.add(User::LEADER)
    leader_user.save
    UserMailer.expects(:new_user_in_leader_area).with(leader_user, user)
    SendEmailToLeadersJob.perform_now(user.id)
  end
end
