require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  ##Testing the validations 
  def setup 
  	@event = Event.new(name:"Test Event", description: "Test description", URL: "www.someurl.com", start_date: "2013-09-12 00:12:12", end_date: "", address1: "4321 Happy Way", address2: "", city:"Orlando", state:"FL", zip: "90210", scholarship_available: "true")
  end

  test "should be valid" do 
  	#Current user as described in setup should be valid
  	assert @event.valid? 
  end

  test "name should be present" do
  	#Confirm empty event name is not valid 
  	@event.name = "    "
  	assert_not @event.valid?
  end 

  test "description should be present" do
  	@event.description = "   "
  	assert_not @event.valid?
  end

  test "start_date should be present" do
  	@event.start_date = "   "
  	assert_not @event.valid?
  end

  test "address1 should be present" do
  	@event.address1 = " "
  	assert_not @event.valid?
  end

  test "city should be present" do
  	@event.city = " "
  	assert_not @event.valid?
  end

  test "state should be present" do
  	@event.state = " "
  	assert_not @event.valid?
  end

  test "zip should be present" do
  	@event.zip = " "
  	assert_not @event.valid?
  end

  test "website validation should accept valid websites" do
  	valid_websites=%w[www.somewebsite.com www.1234.com www.foobar.net]
  	 valid_websites.each do |valid_website|
  	 	@event.URL=valid_website
  	 	assert @event.valid?, "#{valid_website.inspect} should be valid"
  	 end
  	end

  test "website validation should reject invalid urls" do
  	bad_websites = %w[w.badwebsite.com www,stillbad.com abc.fail.com wwww.foobar.com]
  	 bad_websites.each do |bad_website|
  	 	@event.URL = bad_website
  	 	assert_not @event.valid?, "#{bad_website.inspect} should not be valid"
  	 end
  	end

  test "zipcode validation should accept valid zipcodes" do
  	good_zipcodes = %w[12345 12345-1234]
  	 good_zipcodes.each do |good_zipcode|
  	 	@event.zip=good_zipcode
  	 	assert @event.valid?, "#{good_zipcode.inspect} should be valid"
  	 end
  	end

  test "zipcode validation should reject invalid zipcodes" do 
   bad_zipcodes = %w[123456 1234 12345-1 12345-12345]
    bad_zipcodes.each do |bad_zipcode|
    	@event.zip = bad_zipcode
    	assert_not @event.valid?, "#{bad_zipcode.inspect} should not be valid"
    end
  end
end
