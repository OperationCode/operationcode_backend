class Event < ApplicationRecord
	#Allowing URL, end_date, and address2 to be empty 
	validates :name, presence: true
	validates :description, presence: true
	validates :start_date, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	validates :state, presence: true, length: {is: 2} #Dropdown selection on front end?  
	validates :zip, presence: true
	validates :scholarship_available, presence: true 

end
