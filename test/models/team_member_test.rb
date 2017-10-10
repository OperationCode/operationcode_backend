require 'test_helper'

class TeamMemberTest < ActiveSupport::TestCase

    test "member must have name and role" do
        team_member = build(:team_member)
        assert team_member.valid?
    end
    
end