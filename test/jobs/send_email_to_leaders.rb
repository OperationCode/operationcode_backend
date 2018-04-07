require 'test_helper'

class SendEmailToLeadersTest < ActiveJob::TestCase
  test 'send email to leaders if someone signs up within X miles' do

    user = build(:user, email: 'static@email.com', latitude: 40.7, longitude: -73.8)
    leader_user = create(:user, latitude: 40.7001, longitude: -73.8001)
    leader_user.tag_list.add('community-leader')
    leader_user.save
    UserMailer.expects(:new_user_in_leader_area).with(leader_user, user)
    SendEmailToLeaders.perform_now(user)

  end
end
