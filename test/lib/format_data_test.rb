require 'test_helper'

class FormatDataTest < ActiveSupport::TestCase
  test '.csv_to_array' do
    results = FormatData.csv_to_array 'tx'
    assert_equal ['TX'], results

    results = FormatData.csv_to_array 'tx, mn'
    assert_equal ['TX', 'MN'], results

    results = FormatData.csv_to_array '80202, 80126'
    assert_equal ['80202', '80126'], results
  end
end
