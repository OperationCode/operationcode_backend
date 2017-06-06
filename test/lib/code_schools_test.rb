require 'test_helper'

class CodeSchoolsTest < ActiveSupport::TestCase
  test 'raises if config doesnt exist' do
    assert_raises { CodeSchools.all('/a/non/existent/path') }
  end

  test 'it returns schools' do
    c = CodeSchools.all(Rails.root + 'test/support/code_schools/test_config.yml')
    assert_kind_of Array, c
    listing = c.first
    assert_kind_of Array, listing['locations']
    assert_equal 2, listing['locations'].count
  end
end
