class Event < ApplicationRecord
	validates :name, :start_date, :source_updated, :source_type, :address1, :city, presence: true
	validates :source_id, presence: true, uniqueness: {case_sensitive: false}
	VALID_URL_REGEX = URI::regexp
	validates :url, format: {with:VALID_URL_REGEX}
end
