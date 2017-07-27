require 'test_helper'

class EventsCreateTest < ActionDispatch::IntegrationTest
  test 'invalid event information does not save' do
  	assert_no_difference 'Event.count' do
  		post api_v1_events_path, params: {events:{name:"", description: "Incomplete event data"}}
  	end
  end

  test 'valid event information saves' do
  	assert_difference 'Event.count', 1 do
  		post api_v1_events_url params:{event:{name:"Test Event 5", 
  			description: "Test description", url: "http://www.someurl.com", 
  			start_date: "2013-09-12 00:12:12", end_date: "", address1: "4321 Happy Way", 
  			address2: "", city:"Orlando", state:"FL", zip: "90210", scholarship_available: "true"}}, as: :json 
  		end
  	end
end
 	
