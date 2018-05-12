require 'test_helper'
require_relative '../support/meetups/sample_api_responses'

class MeetupTest < ActiveSupport::TestCase
  test 'some test' do
    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(group_endpoint_response)

    parsed_response = Meetup.new.operationcode_data

    assert_equal 1, parsed_response.size
    assert_equal 21767819, parsed_response.first['id']
  end

  test 'group response code of 200 returns response' do
    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(group_endpoint_response)

    assert_nothing_raised { Meetup.new.operationcode_data }
  end

  test 'group response code not equal to 200 raises error' do
    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(build_response(400))

    assert_raises(Exception) { Meetup.new.operationcode_data }
  end

  test 'event response code of 200 returns response' do
    url = 'Operation-Code-Hampton-Roads'

    Meetup.stubs(:get).with("/#{url}/events", options).returns(event_endpoint_response)

    assert_nothing_raised { Meetup.new.get_events_for url }
  end

  test 'event response code not equal to 200 raises error' do
    url = 'Operation-Code-Hampton-Roads'

    Meetup.stubs(:get).with("/#{url}/events", options).returns(build_response(400))

    assert_raises( Exception ) { Meetup.new.get_events_for url }
  end

  #There are 4 events in the stub data, 1 with no venue
  test 'Meetup events with no venue are not included' do
    url = 'Operation-Code-Hampton-Roads'

    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(group_endpoint_response)
    Meetup.stubs(:get).with("/#{url}/events", options).returns(event_endpoint_response)

    events = Meetup.new.event_details_by_group

    assert_equal( events.length, 3 )
  end

  #Event endpoint stubbed reponse has 3 good event records.
  test 'good data saves as new database record' do
    url = 'Operation-Code-Hampton-Roads'

    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(group_endpoint_response)
    Meetup.stubs(:get).with("/#{url}/events", options).returns(event_endpoint_response)

    assert_difference 'Event.count', 3 do
      Meetup.new.add_events_to_database!
    end
  end

  test 'duplicate data does not create new record' do
    url = 'Operation-Code-Hampton-Roads'

    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(group_endpoint_response)
    Meetup.stubs(:get).with("/#{url}/events", options).returns(event_endpoint_response)

    # create a Event record from first item in `event_endpoint_parsed_response`
    assert_equal 0, Event.count
    meetup = Meetup.new
    attributes = meetup.send(:details_for, event_endpoint_parsed_response.first)
    Event.create(attributes)
    assert_equal 1, Event.count

    Meetup.new.add_events_to_database!
    assert_equal 3, Event.count
  end

  test 'updated data is updated in database' do
    url = 'Operation-Code-Hampton-Roads'

    Meetup.stubs(:get).with('/pro/operationcode/groups', options).returns(group_endpoint_response)
    Meetup.stubs(:get).with("/#{url}/events", options).returns(event_endpoint_response)

    attributes = create_and_save_old_event

    Meetup.new.add_events_to_database!

    assert_equal 3, Event.count #Duplicate event was not saved
    assert_equal Event.first[:source_updated], attributes[:source_updated]
    assert_equal Event.first[:name], attributes[:name]
  end

  def options
    Meetup.new.options
  end

  def create_and_save_old_event
    # create a Event record from first item in `event_endpoint_parsed_response`
    assert_equal 0, Event.count
    meetup = Meetup.new
    attributes = meetup.send(:details_for, event_endpoint_parsed_response.first)
    event = Event.new(attributes)

    # change the :source_updated and :name attrs to be something different than
    # the contents of `event_endpoint_parsed_response` before saving it to the db
    old_date = event.source_updated - 1.month
    old_name = 'old name'
    event.source_updated = old_date
    event.name = old_name
    event.save
    event.reload
    assert_equal 1, Event.count
    assert_equal Event.first[:source_updated], old_date
    assert_equal Event.first[:name], old_name
    attributes
  end
end
