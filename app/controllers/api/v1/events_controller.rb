module Api
  module V1
    class EventsController < ApplicationController
      def index
        #render json: Event.all
        @api_data=Meetup.new
  		@meetups = @api_data.get_events #query based on user's location if logged in.  
  		@meetups_json = JSON.parse(@meetups.body)
  	
  	#Should I be using HTTParty here?  It looks like the data format is the same both before and after the call to the meetupAPI 
  	#Only difference is after the parsing I have => 
	#Is there a way to see what parameters are on @meetups easily? 
      end

    end
  end
end