class Scholarship < ApplicationRecord
  has_many :scholarship_applications

  scope :unexpired, -> { where('close_time > ? OR close_time IS NULL', Time.current) }
end
