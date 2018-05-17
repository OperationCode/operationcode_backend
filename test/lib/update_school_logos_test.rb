require 'test_helper'

class UpdateSchoolLogosTest < ActiveSupport::TestCase
  setup do
    Rails.application.load_tasks
    if !CodeSchool.exists?
      Rake::Task['schools:populate'].invoke
    end
  end

  test 'it asserts schools\' logos contain aws urls' do
    Rake::Task['update:school_logos'].invoke
    schools = CodeSchool.all
    assert_kind_of CodeSchool::ActiveRecord_Relation, schools
    schools.each do |school|
      logo = school.logo
      assert_match 'https://s3.amazonaws.com/operationcode-assets', logo
    end
  end
end
