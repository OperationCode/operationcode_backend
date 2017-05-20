class Request < ApplicationRecord
  belongs_to :user
  belongs_to :requested_mentor, class_name: 'User', optional: true
  belongs_to :assigned_mentor, class_name: 'User', optional: true
  belongs_to :service

  validates_presence_of :user

  scope :unclaimed, -> { where(assigned_mentor: nil) }
end
