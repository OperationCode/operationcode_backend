class Meetup
	include HTTParty 
	base_uri 'api.meetup.com'
	#API_KEY = ENV["MEETUP_API_KEY"]

	attr_reader :options 

	def initialize
		@options = {
			query: {
				key: '47634e2c5f583c1d677e79162d1264b',
				sign: "true"
			}
		}
	end

  # GET all Operation Code Pro group data.  Can use URLname to query specific events 
  def operationcode_data	 
  	self.class.get("/pro/operationcode/groups", options).parsed_response #This cuts out all the header stuff
  end

  def get_events_for(urlname)
    puts "I MADE IT THIS FAR #{urlname}"
  	self.class.get("/#{urlname}/events", options).parsed_response
  end

  #Return all meetups based on group names 
  def event_details_by_group
    events = [] #empty array 
  	group_names.each do |group| #for each group
      get_events_for(group).each do |event|
        next unless event['venue'].present?
        events<<details_for(event)
      end
      #events<<get_events_for(group).map { |event|details_for(event) } #This returns a NESTED array 
  	end
  	events.flatten
  end

  def add_events_to_database
    event_details_by_group.each do |event|
      my_event = Event.find_or_initialize_by(source_id: event[:source_id], source: "Meetup") 
      if my_event.new_record?
        my_event.update!(event)
      elsif my_event[:source_updated] < event[:source_updated] #Found in database, updated
        my_event.update!(event)
      end
    end
  end

 private 
	
  # Return all local group names 
  def group_names
  	operationcode_data.map { |group| group["urlname"]  }
  end

  def event_duration(event)
    if event['duration'].present? 
      duration = event['duration'] / 1000
    else
      duration = 0
    end
  end

  def details_for(event) # IF ANY OF THESE FIELDS IS MISSING IT KILLS IT 
    start_date = Time.at(event['time']/1000)

  	{
  		source_id:event['id'],
      source_updated: Time.at(event['updated']).to_datetime,
  		name:event['name'],
  		description: event['description'],
  		url:event['link'],
  		start_date:start_date.to_datetime,
  		end_date: (start_date + event_duration(event)).to_datetime,  #end time is not provided, only start time and duration. 
      address1:event['venue']['address_1'],
  		address2:event['venue']['address_2'],
  		city: event['venue']['city'],
  		state: event['venue']['state'],
  		zip: event['venue']['zip'],  
      group: event['group']['name'],
      source: "Meetup"
  		#scholarship_available: event[]
  	}
  end
end



  