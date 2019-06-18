require 'test_helper'

class CodeSchoolTest < ActiveSupport::TestCase
  def setup
    @code_school = build :code_school
  end

  test 'is_partner should be present and default to false' do
    assert_not @code_school.is_partner
  end

  test 'rep_name should be present' do
    assert @code_school.rep_name.present?
  end

  test 'rep_email should be present' do
    assert @code_school.rep_email.present?
  end

  test 'url should be present' do
    assert @code_school.url.present?
  end

  test 'url does not change when url is correct' do
    previous_url = @code_school.url
    @code_school.run_callbacks :create
    assert @code_school.url.eql?(previous_url)
  end

  test 'url gets updated with HTTPS scheme when url has no scheme' do
    @code_school.url = 'stackoverflow.com'
    @code_school.run_callbacks :create
    assert @code_school.url.eql?('https://stackoverflow.com')
  end

  test 'url gets updated with HTTP scheme when url has no scheme' do
    @code_school.url = 'neverssl.com'
    @code_school.run_callbacks :create
    assert @code_school.url.eql?('http://neverssl.com')
  end
end
