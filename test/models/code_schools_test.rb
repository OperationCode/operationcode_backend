require 'test_helper'

class CodeSchoolTest < ActiveSupport::TestCase
  def setup
    @code_school = build :code_school
  end

  test 'is_partner should be present and default to false' do
    assert @code_school.is_partner == false
  end

  test 'rep_name should be present' do
    assert @code_school.rep_name.present?
  end

  test 'rep_email should be present' do
    assert @code_school.rep_email.present?
  end
end
