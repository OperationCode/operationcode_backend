class CodeSchool < ApplicationRecord
  validates :name, :logo, :url, presence: true
  validates :url, presence: true, format: { with: %r{\Ahttps://(.*)}, message: 'must be HTTPS, if unable please secure your site' }
  validates_inclusion_of :full_time, :hardware_included, :has_online, :online_only, :in => [true, false]
  has_many :locations, -> { order('state ASC, city ASC') }, dependent: :destroy
end
