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
  		events[group]=get_events_for(group).map {|event|details_for(event)}
  	end
  	events 
  end


 private 
	
	
  # Return all local group names 
  def group_names
  	operationcode_data.map { |group| group["urlname"]  }
  end

  def details_for(event)
  	{
  		id:event['id'],
  		name:event['name'],
  		description: event['description'],
  		url:event['link'],
  		start_date:event['time'],
  		#end_date:event[]
  		address1:event['venue']['address1'],
  		#address2:event[]
  		city: event['venue']['city'],
  		state: event['venue']['state'],
  		zip: event['venue']['zip'] 
  		#scholarship_available: event[]
  	}
  end

end


  