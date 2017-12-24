class Location < ApplicationRecord
  belongs_to :code_school
  validates :address1, :city, :state, :zip, presence: true
  validates :va_accepted, inclusion: { in: [true, false] }
end
