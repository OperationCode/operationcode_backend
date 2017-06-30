class TeamMember < ApplicationRecord
  validates :name, :role, presence: true
end
