require 'test_helper'

class FormatDataTest < ActiveSupport::TestCase
  test '.csv_to_array' do
    results = FormatData.csv_to_array 'TX'
    assert_equal ['tx'], results

    results = FormatData.csv_to_array 'TX, MN'
    assert_equal ['tx', 'mn'], results

    results = FormatData.csv_to_array '80202, 80126'
    assert_equal ['80202', '80126'], results
  end
end
