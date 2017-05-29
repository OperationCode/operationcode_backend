require 'test_helper'

class AddUserToAirtablesJobTest < ActiveJob::TestCase
  test 'it adds a user to airtables' do
    user = build(:user)
    Operationcode::Airtable.any_instance.expects(:create).with(
      email: user.email,
      zip: user.zip,
      latitude: user.latitude,
      longitude: user.longitude,
      created_at: user.created_at,
      updated_at: user.updated_at
    )
    AddUserToAirtablesJob.perform_now(user)
  end

  test 'it doesnt add a user if it exists' do
    user = build(:user)
    Operationcode::Airtable.any_instance.expects(:create).once.with(
      email: user.email,
      zip: user.zip,
      latitude: user.latitude,
      longitude: user.longitude,
      created_at: user.created_at,
      updated_at: user.updated_at
    )
    AddUserToAirtablesJob.perform_now(user)

    Operationcode::Airtable.any_instance.stubs(:find_by).returns(true)
    AddUserToAirtablesJob.perform_now(user)
  end
end
