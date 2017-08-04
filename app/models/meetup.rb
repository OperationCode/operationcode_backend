class Meetup
	include HTTParty 
	base_uri 'api.meetup.com'
	API_KEY = ENV["MEETUP_API_KEY"]

	# def api_key
	# 	@api_key = '5187488' #Should be an ENV variable 
	# end

	# def api_key_two
	# 	@api_key_two = '05b5d92d7a520168cf978bc769da4fdb4630f0e9'
	# end

	# def base_path 
	# 	"/operation-code-hampton-roads/events?photo-host=public&page=20&sig_id=#{api_key}&sig=#{api_key_two}"
	# end

	# def get_events
	# 	self.class.get(base_path).parsed_response
	# end
	# #url should be /pro/operation-code/events/.....

  def base_path
  	#{}"/operation-code-hampton-roads/events?photo-host=public&page=20"
  	#{}"/pro/operationcode/groups?key=47634e2c5f583c1d677e79162d1264b&sign=true"
  	"/pro/operationcode/groups?key=#{MEETUP_API_KEY}&sign=true"

  end

  def get_events
  	self.class.get(base_path).parsed_response
  end

end 