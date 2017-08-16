 namespace :meetup do
   desc "Rake task to get Meetup API data"
   task :fetch => :environment do 
   		events = Meetup.new.event_details_by_group # Returns a hash set up in meetup.rb
      	events.each do |group, event| # Cycle through groups and list each event.  Event can be an array (if a group has multiple meetups)
      		event.each do |event|
      			new_event = Event.new(event) #Validation requires meetup_id be unique 
      			new_event.save 
      			if !new_event.valid? #It didn't save, so the meetup id exists 
      				temp_event = Event.find_by(meetup_id: event[:meetup_id])
      				temp_event.update_attributes(event)
      			end
      		end
      	end
      end
  end

    
  
