class CodeSchool < ApplicationRecord
  validates :name, :url, :logo, :full_time, :hardware_included, :has_online, :online_only, presence: true
  has_many :locations, dependent: :destroy
end
