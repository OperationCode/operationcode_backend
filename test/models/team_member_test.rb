require 'test_helper'

class TeamMemberTest < ActiveSupport::TestCase
  test 'member must have name, role and group' do
    team_member = build(:team_member)
    assert team_member.valid?
  end

  test "member group must be 'team' or 'board'" do
    intern = build(:team_member, group: 'intern')
    team = build(:team_member, :team)
    board = build(:team_member, :board)
    executive = build(:team_member, :executive)

    assert intern.invalid?
    assert team.valid?
    assert board.valid?
    assert executive.valid?
  end
end
