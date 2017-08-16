class Meetup
	include HTTParty 
	base_uri 'api.meetup.com'
	#API_KEY = ENV["MEETUP_API_KEY"]

	attr_reader :options #Can now only GET options.  This means I cannot set options in this class 

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
  	self.class.get("/pro/operationcode/groups", @options).parsed_response #This cuts out all the header stuff
  end

  def get_events_for(urlname)
  		self.class.get("/#{urlname}/events", @options).parsed_response
  end

  #Return all meetups based on group names 
  def event_details_by_group
  	events={} #empty hash 
  	group_names.each do |group|
  		events[group]=get_events_for(group).map {|event| details_for(event)}
  	end
  	events 
  end

 private 
	
  # Return all local group names 
  def group_names
  	operationcode_data.map { |group| group["urlname"]  }
  end

  def details_for(event)
    start_date = Time.at(event['time']/1000)
    if event['duration'].present? 
      duration = event['duration']/1000
    else
      duration = 0
    end
  	{
  		meetup_id:event['id'],
      meetup_updated: Time.at(event['updated']).to_datetime,
  		name:event['name'],
  		description: event['description'],
  		url:event['link'],
  		start_date:start_date.to_datetime,
  		end_date: (start_date+duration).to_datetime, #end time is not provided, only start time and duration. 
      address1:event['venue']['address_1'],
  		address2:event['venue']['address_2'],
  		city: event['venue']['city'],
  		state: event['venue']['state'],
  		zip: event['venue']['zip']  
  		#scholarship_available: event[]
  	}
  end

end


  