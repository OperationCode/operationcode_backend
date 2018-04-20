require 'test_helper'

class CodeSchoolTest < ActiveSupport::TestCase
  def setup
    @code_school = build :code_school
  end

  test "is_partner should be present" do
    @code_school.is_partner = true
    assert @code_school.valid?
  end
end
