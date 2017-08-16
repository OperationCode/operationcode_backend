module Api
  module V1
    class EventsController < ApplicationController
      
      def index
        render json: Event.all, status: :ok
     #  rescue StandardError=>EventsController
    	# render json: {errors:e.message}, status: :unprocessable_entity 
      end

    end
  end
end


#@event = Event.new(name:"Test Event", description: "Test description", url: "http://www.someurl.com", start_date: "2013-09-12 00:12:12", end_date: "", address1: "4321 Happy Way", address2: "", city:"Orlando", state:"FL", zip: "90210", scholarship_available: "true")

#Next Steps : 
#Figure out why start_date is not getting saved in details_by_group (type problem)
#Remove zip validation, not all have it 
#Remove scholarship validation, not all have
#Figure out why other records are failing
#Need a case for when it doesn't save 
#Sometimes the state is nil from Meetup 
#Meetup data is sloppy 