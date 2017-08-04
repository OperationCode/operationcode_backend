class ScholarshipApplication < ApplicationRecord
  validate :user_is_verified

  belongs_to :user
  belongs_to :scholarship

  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
  delegate :verified, to: :user, prefix: true

  def user_is_verified
    unless self.user_verified
      errors.add(:verified, "Only verified users may submit applications")
    end
  end
end
