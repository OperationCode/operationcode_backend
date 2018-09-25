class ScholarshipApplication < ApplicationRecord
  validates :user_id, uniqueness: {scope: :scholarship_id}

  belongs_to :user
  belongs_to :scholarship

  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
end
