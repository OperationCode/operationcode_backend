class TeamMember < ApplicationRecord
  validates :name, :role, :group, presence: true
  validates :group, inclusion: { in: %w| team board | }
end
