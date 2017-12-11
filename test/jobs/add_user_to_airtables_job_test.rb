require 'test_helper'

class AddUserToAirtablesJobTest < ActiveJob::TestCase
  test 'it adds a user to airtables' do
    user = create(:user)
    mock_member = mock_air_table_member_for(user)

    AirTableMember.expects(:new).with(
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      slack_name: user.slack_name,
      education: user.education,
      employment_status: user.employment_status,
      email: user.email,
      zip: user.zip,
    ).returns(mock_member)

    AirTableMember.any_instance.expects(:create).once

    AddUserToAirtablesJob.perform_now(user)
  end

  test 'it logs an error when the AirTable record exists' do
    user = build(:user)
    mock_member = mock_air_table_member_for(user)

    AirTableMember.stubs(:new).returns(mock_member)
    AirTableMember.stubs(:all).returns([mock_member])
    
    AirTableMember.any_instance.expects(:create).never

    AddUserToAirtablesJob.perform_now(user)
  end

  private

  def mock_air_table_member_for(user)
    AirTableMember.new(
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
