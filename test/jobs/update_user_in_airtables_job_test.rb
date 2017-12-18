require 'test_helper'

class UpdateUserInAirtablesJobTest < ActiveJob::TestCase
  test 'it finds the user in airtables' do
    user = create(:user)
    member = mock_air_table_member_for(user)

    AirTableMember.expects(:all).returns([member])
    AirTableMember.any_instance.stubs(:save).returns(true)

    UpdateUserInAirtablesJob.perform_now(user)
  end

  test 'it updates the user in airtables' do
    user = create(:user)
    member = mock_air_table_member_for(user)

    AirTableMember.stubs(:all).returns([member])

    AirTableMember.any_instance.expects(:save).once

    UpdateUserInAirtablesJob.perform_now(user)
  end

  test 'it creates the user if the user does not exist' do
    user = create(:user)
    member = mock_air_table_member_for(user)

    AirTableMember.stubs(:all).returns([])

    AddUserToAirtablesJob.expects(:perform_later).with(user)

    UpdateUserInAirtablesJob.perform_now(user)
  end

  private

  def mock_air_table_member_for(user)
    member = AirTableMember.new(
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      slack_name: user.slack_name,
      education: user.education,
      employment_status: user.employment_status,
      email: user.email,
      zip: user.zip,
    )
  end
end
