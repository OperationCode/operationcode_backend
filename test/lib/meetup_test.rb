require 'test_helper'
require_relative '../support/meetups/sample_api_responses'

class MeetupTest < ActiveSupport::TestCase

#The code is structured so /groups is always called before /events. Both responses must be stubbed.
#Stub data is dependent on this urlname, do not change
  setup do
    Event.delete_all
    Meetup.stubs(:get).with("/pro/operationcode/groups", options).returns(group_endpoint_response)
    @urlname = "Operation-Code-Hampton-Roads"
    Meetup.stubs(:get).with("/#{@urlname}/events", options).returns(event_endpoint_response)
    @event1 = {:source_id=>"243869029",
      :source_updated=>Date.today,
      :name=>"Code and Coffee",
      :description=>
       "<p>Have you always wanted to try programming? Are you just getting started and have questions? Or maybe you have some experience under your belt and want to chat with people that get what you're talking about.</p> <p>Join us at Between Friends Coffeshop &amp; Cafe! Drinks and treats provided! Make sure to RSVP so we how many people to prepare for :)</p> ",
      :url=>"https://www.meetup.com/MilSpouseCoders-Robins-AFB/events/243869029/",
      :start_date=>Date.today,
      :end_date=>Date.today,
      :address1=>"1080 Georgia 96",
      :address2=>nil,
      :city=>"Warner Robins",
      :state=>nil,
      :zip=>nil,
      :group=>"MilSpouseCoders - Robins AFB",
      :source_type=>"Meetup"
    }

  end

  #response.code defaults to 200 in stub data
  test "group response code of 200 returns response" do
    assert_nothing_raised { Meetup.new.operationcode_data }
  end

  test "group response code not equal to 200 raises error" do
  	Meetup.stubs(:get).with("/pro/operationcode/groups", options).returns(build_response(400))
  	assert_raises(Exception) { Meetup.new.operationcode_data }
  end

  test "event response code of 200 returns response" do
  	assert_nothing_raised { Meetup.new.get_events_for(@urlname) }
  end

  test "event response code not equal to 200 raises error" do
  	Meetup.stubs(:get).with("/#{@urlname}/events", options).returns(build_response(400))
  	assert_raises( Exception ) { Meetup.new.get_events_for(urlname) }
  end

  #There are 4 events in the stub data, 1 with no venue
  test "Meetup events with no venue are not included" do
  	events = Meetup.new.event_details_by_group
  	assert_equal( events.length, 3 )
  end

  #Event endpoint stubbed reponse has 3 good event records.
  test "good data saves as new database record" do
    assert_difference 'Event.count', 3 do
      Meetup.new.add_events_to_database!
    end
  end

  test "duplicate data does not create new record" do
    dup_event = @event1
    events = [ @event1, dup_event ] #This should be an array of hashes
    Meetup.stubs(:event_details_by_group).returns(events)
    Meetup.new.add_events_to_database!
    assert_equal 1, Event.count
  end

  test "updated data is updated in database" do
    event1 = Event.create(@event1)
    assert_equal Event.first[:source_updated], Date.today #Event1 was saved in database
    assert_equal Event.first[:name], "Code and Coffee"
    updated_event = @event1
    updated_event[:source_updated] = 2.days.from_now
    updated_event[:name] = "I was updated via Meetup"
    Meetup.stubs(:event_details_by_group).returns(updated_event)

    Meetup.new.add_events_to_database!
    assert_equal 1, Event.count #Duplicate event was not saved
    assert_equal Event.first[:source_updated], 2.days.from_now
    assert_equal Event.first[:name], "I was updated via Meetup"
  end

  def options
    Meetup.new.options
  end
end
