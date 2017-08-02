class Meetup
	include HTTParty 
	base_uri 'api.meetup.com'

	def api_key
		@api_key = '5187488' #Should be an ENV variable 
	end

	def api_key_two
		@api_key_two = '05b5d92d7a520168cf978bc769da4fdb4630f0e9'
	end

	def base_path 
		"/operation-code-hampton-roads/events?photo-host=public&page=20&sig_id=#{api_key}&sig=#{api_key_two}"
	end

	def get_events
		self.class.get(base_path).parsed_response
	end

end 