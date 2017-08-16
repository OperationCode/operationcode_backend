class Event < ApplicationRecord
	#Allowing URL, end_date, and address2 to be empty 
	  validates :name, presence: true
	# validates :description, presence: true
	  validates :start_date, presence: true
	  validates :meetup_id, presence: true, uniqueness: {case_sensitive: false}
	  validates :meetup_updated, presence: true 
	# validates :address1, presence: true
	# validates :city, presence: true
	# validates :state, presence: true, length: {is: 2} #Dropdown selection on front end?  
	# VALID_ZIP_REGEX= /\A\d{5}-?\d{4}?\z/
	# #validates :zip, presence: true, format:{with:VALID_ZIP_REGEX}
	# #validates :scholarship_available, inclusion: {in: [true, false]}
	# VALID_URL_REGEX = URI::regexp 
	# validates :url, format: {with:VALID_URL_REGEX}

end
