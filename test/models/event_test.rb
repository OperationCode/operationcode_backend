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
  	assert @user.valid? 
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

  test "scholarship_available should be present" do
  	@event.scholarship_available = " "
  	assert_not @event.valid?
  end



  end
