require 'test_helper'

class EventsCreateTest < ActionDispatch::IntegrationTest
  setup do
    Event.delete_all
  end

  test 'valid event information saves' do
    assert_difference 'Event.count', 1 do
      create :event, :updated_today
    end
  end

  test 'find_or_initialize_by finds duplicate event by source_id and source' do
    event_in_database = create :event, :updated_today
    meetup_event = event_in_database
    my_event = Event.find_or_initialize_by(source_id: meetup_event[:source_id], source: "Meetup") 
    assert_equal my_event, meetup_event
  end

  test 'find_or_initialize_by creates new event if event is not in database' do
    meetup_event = build :event, :updated_today
    my_event = Event.find_or_initialize_by(source_id: meetup_event[:source_id], source: "Meetup") 
    assert my_event.new_record?
  end
