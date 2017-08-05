class Meetup
	include HTTParty 
	base_uri 'api.meetup.com'
	#API_KEY = ENV["MEETUP_API_KEY"]
	
  def base_path
  	"/pro/operationcode/groups?key=47634e2c5f583c1d677e79162d1264b&sign=true"
  end

  def group_path
  	"/events?photo-host=public&page=20"
  end

  def get_all_pro_data
  	operation_code_group = self.class.get(base_path).parsed_response
  end

  def get_groups
  		@group_names = [] #Blank array of group names 
  		operation_code_group = get_all_pro_data 
  		operation_code_group.each do |group|
  			@group_names << group["urlname"]
  		end
  		@group_names 
  end

  def get_all_meetups
  	@all_meetups = []
  	array_of_groups = get_groups 
  	array_of_groups.each do |group|
  		url= "api.meetup.com/#{group}#{group_path}"
  		@all_meetups << self.class.get(url)
  	end
  	@all_meetups
  end
end 