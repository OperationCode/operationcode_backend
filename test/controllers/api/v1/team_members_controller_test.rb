require 'test_helper'

class Api::V1::TeamMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
  end

  test ":index endpoint returns a JSON list of all TeamMembers" do
    john = create(:team_member)
    alex = create(:team_member, name: "Alex Johnson")

    get api_v1_team_members_url, as: :json

    [john.name, alex.name].each do |team_member|
      assert_equal true, response.parsed_body.any? { |member| member["name"] == team_member }
    end
  end

  test ":create endpoint creates a new TeamMember" do
    params = {
      team_member: {
        name: "Alex Johnson",
        role: "Board Member"
      }
    }

    post api_v1_team_members_url, headers: @headers, params: params, as: :json

    alex = TeamMember.first
    assert_equal({ 'team_member' => alex.id }, response.parsed_body)
  end


  test ":update endpoint updates an existing TeamMember" do
    alex = create(:team_member, name: "Alex Johnson")
    new_role = "Legislative Affairs"
    params = {
      team_member: {
        id: alex.id,
        name: alex.name,
        role: new_role
      }
    }

    put api_v1_team_member_url(alex.id), headers: @headers, params: params, as: :json

    alex = TeamMember.first
    assert_equal response.status, 200
    assert_equal alex.role, new_role
  end

  test ":destroy endpoint destroys an existing TeamMember" do
    alex = create(:team_member, name: "Alex Johnson")
    params = {
      team_member: {
        id: alex.id,
        name: alex.name,
        role: alex.role
      }
    }

    delete api_v1_team_member_url(alex.id), headers: @headers, params: params, as: :json

    assert_equal response.status, 200
    assert_equal TeamMember.count, 0
  end
end
