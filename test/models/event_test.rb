require 'test_helper'

class EventTest < ActiveSupport::TestCase

  ##Testing the validations
  def setup
    @event = build :event, :updated_today
  end

  test 'should be valid' do
  	#Current event as described in setup should be valid
  	assert @event.valid?
  end

  test 'name should be present' do
  	#Confirm empty event name is not valid
  	@event.name = '    '
  	assert_not @event.valid?
  end

  test 'start_date should be present' do
  	@event.start_date = '   '
  	assert_not @event.valid?
  end

  test 'address1 should be present' do
  	@event.address1 = ' '
  	assert_not @event.valid?
  end

  test 'city should be present' do
  	@event.city = ' '
  	assert_not @event.valid?
  end

  test 'website validation should accept valid websites' do
  	valid_websites = %w[http://www.somewebsite.com https://www.1234.com http://www.foobar.net]
    valid_websites.each do |valid_website|
      @event.url = valid_website
      assert @event.valid?, "#{valid_website.inspect} should be valid"
    end
  end

  test 'website validation should reject invalid urls' do
  	bad_websites = %w[w.badwebsite.com www,stillbad.com abc.fail.com wwww.foobar.com]
  	bad_websites.each do |bad_website|
      @event.url = bad_website
      assert_not @event.valid?, "#{bad_website.inspect} should not be valid"
    end
  end
end
