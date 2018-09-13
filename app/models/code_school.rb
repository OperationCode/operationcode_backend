class CodeSchool < ApplicationRecord
  validates :name, :url, :logo, presence: true
  validates_inclusion_of :full_time, :hardware_included, :has_online, :online_only, :in => [true, false]
  has_many :locations, -> { order('state ASC, city ASC') }, dependent: :destroy
end
