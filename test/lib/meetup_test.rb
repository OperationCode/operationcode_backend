require 'test_helper'
require_relative '../support/meetups/sample_api_responses'

class MeetupTest < ActiveSupport::TestCase
  test "group response code of 200 returns response" do
    Meetup.stubs(:get).with("/pro/operationcode/groups", options).returns(group_endpoint_response) #Returns response which includes response.parsed_response and response.code
    assert_nothing_raised { Meetup.new.operationcode_data }
  end

  test "group response code not equal to 200 raises error" do
  	Meetup.stubs(:get).with("/pro/operationcode/groups", options).returns(build_response(400))
  	assert_raises(Exception) { Meetup.new.operationcode_data }
  end

  test "event response code of 200 returns response" do
  	urlname = "Operation-Code-Hampton-Roads"
  	Meetup.stubs(:get).with("/#{urlname}/events", options).returns(event_endpoint_response)
  	assert_nothing_raised { Meetup.new.get_events_for(urlname) }
  end

  test "event response code not equal to 200 raises error" do
  	urlname = "Operation-Code-Hampton-Roads"
  	Meetup.stubs(:get).with("/#{urlname}/events", options).returns(build_response(400))
  	assert_raises( Exception ) { Meetup.new.get_events_for(urlname) }
  end

  test "Meetup events with no venue are not included" do
  	Meetup.stubs(:get).with("/pro/operationcode/groups", options).returns(group_endpoint_response)
  	Meetup.stubs(:get).with("/#{urlname}/events", options).returns(event_endpoint_response)
  	events = Meetup.new.event_details_by_group
  	assert_equal( events.length, 3 )
  end

  test "good data saves as new database record"
  	Event.delete_all
  	Meetup.stubs(:get).with("/#{urlname}/events", options).returns(event_endpoint_response)

  test 'valid event information saves' do
    assert_difference 'Event.count', 1 do
      create :event, :updated_today
    end

  def options
    Meetup.new.options
  end
end


