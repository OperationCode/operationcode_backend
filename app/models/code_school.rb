class CodeSchool < ApplicationRecord
  validates :name, :url, :logo, presence: true
  validates_inclusion_of :full_time, :hardware_included, :has_online, :in => [true, false]
  has_many :locations, dependent: :destroy
end
