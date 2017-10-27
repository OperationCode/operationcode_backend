class Event < ApplicationRecord
	validates :name, :start_date, :source_updated, :source_id, :source_type, :address1, :city, presence: true
	validates :source_id, uniqueness: { scope: :source_type }

	VALID_URL_REGEX = URI::regexp
	validates :url, format: {with:VALID_URL_REGEX}
end
