class Squad < ApplicationRecord
  belongs_to :leader, class_name: 'User'

  validates_numericality_of :maximum, greater_than_or_equal_to: :minimum
end
