class TeamMember < ApplicationRecord
  BOARD_GROUP_NAME = 'board'.freeze
  EXECUTIVE_GROUP_NAME = 'executive'.freeze
  TEAM_GROUP_NAME = 'team'.freeze

  validates :name, :role, :group, presence: true
  validates :group, inclusion: {
    in: [BOARD_GROUP_NAME, EXECUTIVE_GROUP_NAME, TEAM_GROUP_NAME]
  }
end
