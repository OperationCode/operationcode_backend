require 'test_helper'

class FormatDataTest < ActiveSupport::TestCase
  test '.csv_to_array' do
    results = FormatData.csv_to_array '80202'
    assert_equal ['80202'], results

    results = FormatData.csv_to_array '80202, 80126'
    assert_equal ['80202', '80126'], results

    results = FormatData.csv_to_array 'TX, MN'
    assert_equal ['TX', 'MN'], results
  end
end
