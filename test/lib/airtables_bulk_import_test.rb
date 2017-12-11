require 'test_helper'

class AirtablesBulkImportTest < ActiveSupport::TestCase
  test 'finds all users' do
    User.expects(:all).returns([])
    AirtablesBulkImport.execute
  end

  test 'queues a job for a user' do
    tom = create :user

    AddUserToAirtablesJob.expects(:perform_later).with(tom)
    AirtablesBulkImport.execute
  end

  test 'queues jobs for all users' do
    tom = create :user
    sam = create :user
 
    AddUserToAirtablesJob.expects(:perform_later).twice
    AirtablesBulkImport.execute
  end

end
