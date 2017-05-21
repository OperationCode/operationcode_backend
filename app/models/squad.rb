class Squad < ApplicationRecord
  belongs_to :leader, class_name: 'User'
  has_many :squad_mentors
  has_many :mentors, through: :squad_mentors, source: :user
  has_many :squad_members
  has_many :members, through: :squad_members, source: :user

  validates_numericality_of :maximum, greater_than_or_equal_to: :minimum
  validate :mentors_must_be_mentors

  def add_member(user)
    if user.mentor?
      mentors << user unless mentors.include?(user)
    else
      members << user unless members.include?(user)
    end
  end

  private

  def mentors_must_be_mentors
    unless mentors.all?(&:mentor)
      errors.add(:base, 'Mentors must be mentors')
    end
  end

end
