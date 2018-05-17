class Meetup
  include HTTParty
  base_uri 'api.meetup.com'

  attr_reader :options

  def initialize
    api_key  = OperationCode.fetch_secret_with(name: :meetup_api_key)
    @options = {
      query: {
      key: api_key,
      sign: 'true'
      }
    }
  end

  # GET all Operation Code Pro data. Returns all op-code groups.
  def operationcode_data
    response = self.class.get('/pro/operationcode/groups', options)
    return_value_for response
  end

  # GET events for each group
  def get_events_for(urlname)
    response = self.class.get("/#{urlname}/events", options)
    return_value_for response
  end

  #Return all meetups based on group names if venue is present. Return array of all op-code events
  def event_details_by_group
    events = []
    group_names.each do |group|
      get_events_for(group).each do |event|
        next unless event['venue'].present?
        events << details_for(event)
      end
    end
    events.flatten
  end

  def add_events_to_database!
    event_details_by_group.each do |event|
      saved_event = Event.find_or_initialize_by(source_id: event[:source_id], source_type: 'Meetup')
      if saved_event.new_record? || saved_event_updated?(saved_event, event)
        saved_event.update!(event)
      end
    end
  end

 private

  def saved_event_updated?(saved_event, event)
    saved_event[:source_updated] < event[:source_updated]
  end

  def group_names
    operationcode_data.map { |group| group['urlname'] }
  end

  def event_duration(event)
    if event['duration'].present?
      event['duration'] / 1000
    else
      0
    end
  end

  def return_value_for(response)
    if response.code.to_i == 200
      response.parsed_response
    else
      raise 'Error fetching data from Meetup API'
    end
  end

  def details_for(event)
    start_date = Time.at(event['time'] / 1000)

    {
      source_id: event['id'],
      source_updated: Time.at(event['updated']).to_datetime, #Look into this further. giving weird date
      name: event['name'],
      description: event['description'],
      url: event['link'],
      start_date: start_date.to_datetime,
      end_date: (start_date + event_duration(event)).to_datetime,  #end time is not provided, only start time and duration.
      address1: event['venue']['address_1'],
      address2: event['venue']['address_2'],
      city: event['venue']['city'],
      state: event['venue']['state'],
      zip: event['venue']['zip'],
      group: event['group']['name'],
      source_type: 'Meetup'
    }
  end
end
