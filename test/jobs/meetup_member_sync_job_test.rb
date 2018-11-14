require 'test_helper'

class MeetupMemberSyncJobTest < ActiveSupport::TestCase
  member = {
    'email' => 'test@test.com',
    'lat' => 36.900001525878906,
    'lon' => -76.20999908447266,
    'city' => 'Norfolk',
    'state' => 'VA'
  }

  test 'it only updates nil fields on a found user' do
    job = MeetupMemberSyncJob.new
    user_id = FactoryGirl.create(:user, email: 'test@test.com', city: nil).id
    Meetup.any_instance.expects(:members_by_email).returns('test@test.com' => member)
    job.perform

    user = User.find(user_id)
    assert user.city == 'Norfolk'
    assert user.state != 'VA'
  end

  test 'it only updates users with matching emails' do
    job = MeetupMemberSyncJob.new
    FactoryGirl.create(:user, email: 'test@test.com', city: nil)
    user2 = FactoryGirl.create(:user, email: 'test2@test.com', city: nil)

    Meetup.any_instance.expects(:members_by_email).returns('test@test.com' => member)
    job.perform

    assert user2 == User.find(user2.id)
  end
end
