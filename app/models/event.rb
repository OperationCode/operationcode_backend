class Event < ApplicationRecord
	#Allowing URL, end_date, and address2 to be empty 
	validates :name, presence: true
	validates :description, presence: true
	validates :start_date, presence: true
	validates :address1, presence: true
	validates :city, presence: true
	validates :state, presence: true, length: {is: 2} #Dropdown selection on front end?  
	VALID_ZIP_REGEX= /\A\d{5}-?\d{4}?\z/
	validates :zip, presence: true, format:{with:VALID_ZIP_REGEX}
	#This validation doesn't work the way I think it should.  All strings are converted to true except false.  This does prevent nil, but does not force the text "true" or "false"
	validates :scholarship_available, inclusion: {in: [true, false]}
	
	#This regex only accounts for www. addresses, I assume we won't be linking to ftp sites? 
	#Does not catch www.. I don't know of any websites starting with ., but it is a valid unreserved character so I didn't want to cut it.  
	VALID_URL_REGEX = /\Awww\.+.+\.[a-z]+\z/i 
	validates :URL, format: {with:VALID_URL_REGEX}

	
	

end
