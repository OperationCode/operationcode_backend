require 'test_helper'

class UsersByLocationTest < ActiveSupport::TestCase
  setup do
    tom = create :user
    sam = create :user

    tom.update_columns latitude: 39.763034, longitude: -104.961969, zip: '80205', state: 'CO'
    sam.update_columns latitude: 30.312601, longitude: -97.738591, zip: '78756', state: 'TX'
  end

  test '#count by state' do
    params  = { state: 'CO' }
    results = UsersByLocation.new(params).count
    assert_equal 1, results

    params  = { state: 'TX' }
    results = UsersByLocation.new(params).count
    assert_equal 1, results

    params  = { state: 'CO, TX' }
    results = UsersByLocation.new(params).count
    assert_equal 2, results
  end

  test '#count by zip' do
    params  = { zip: '80205' }
    results = UsersByLocation.new(params).count
    assert_equal 1, results

    params  = { zip: '78756' }
    results = UsersByLocation.new(params).count
    assert_equal 1, results

    params  = { zip: '80205, 78756' }
    results = UsersByLocation.new(params).count
    assert_equal 2, results
  end

  test '#count by lat_long' do
    params  = { lat_long: [39.763034, -104.961969] }
    results = UsersByLocation.new(params).count
    assert_equal 1, results

    params  = { lat_long: [30.312601, -97.738591] }
    results = UsersByLocation.new(params).count
    assert_equal 1, results
  end
end

