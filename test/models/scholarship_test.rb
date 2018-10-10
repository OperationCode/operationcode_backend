require 'test_helper'

class ScholarshipTest < ActiveSupport::TestCase
  test 'unexpired returns unexpired scholarships' do
    nil_date = create :scholarship, close_time: nil
    active_date = create :scholarship, close_time: 3.days.from_now

    assert_equal Scholarship.unexpired, [nil_date, active_date]
  end

  test 'unexpired doesn\'t return expired scholarships' do
    expired_date = create :scholarship, close_time: 3.days.ago

    assert_not_includes Scholarship.unexpired, expired_date
  end
end
