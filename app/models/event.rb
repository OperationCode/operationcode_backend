class Event < ApplicationRecord
	validates :name, presence: true
	validates :start_date, presence: true
	validates :source_id, presence: true, uniqueness: {case_sensitive: false}
	validates :source_updated, presence: true 
	validates :source, presence: true 
	validates :address1, presence: true
	validates :city, presence: true  
	VALID_URL_REGEX = URI::regexp 
	validates :url, format: {with:VALID_URL_REGEX}
end
