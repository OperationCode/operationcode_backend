require 'test_helper'

class VerifyDbTest < ActiveSupport::TestCase

  test 'verify test database' do
    #Check that the correct database used for testing
    query = "SELECT * FROM ar_internal_metadata"
    sql = ActiveRecord::Base.connection.execute(query).first
    assert_equal("test", sql["value"] )
  end

end
