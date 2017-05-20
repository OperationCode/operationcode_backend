class Squad < ApplicationRecord
  belongs_to :leader, class_name: 'User'
  has_many :squad_mentors
  has_many :mentors, through: :squad_mentors, source: :user

  validates_numericality_of :maximum, greater_than_or_equal_to: :minimum
  validate :mentors_must_be_mentors

  private

  def mentors_must_be_mentors
    unless mentors.all?(&:mentor)
      errors.add(:base, 'Mentors must be mentors')
    end
  end

end
