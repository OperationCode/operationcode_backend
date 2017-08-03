class ScholarshipApplication < ApplicationRecord
  validate :user_is_verified

  belongs_to :user
  belongs_to :scholarship

  delegate :name, to: :user
  delegate :email, to: :user

  def user_is_verified
    unless self.user.verified
      errors.add(:verified, "Only verified users may submit applications")
    end
  end
end
