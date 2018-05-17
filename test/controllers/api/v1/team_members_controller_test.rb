require 'test_helper'

class Api::V1::TeamMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)
    @headers = authorization_headers(user)
  end

  test ':index endpoint returns a JSON list of all TeamMembers' do
    john = create(:team_member)
    alex = create(:team_member, name: 'Alex Johnson')

    get api_v1_team_members_url, as: :json

    [john.name, alex.name].each do |team_member|
      assert_equal true, response.parsed_body.any? { |member| member['name'] == team_member }
    end
  end

  test ':create endpoint creates a new TeamMember' do
    params = {
      name: 'Alex Johnson',
      role: 'Board Member',
      group: TeamMember::BOARD_GROUP_NAME
    }

    post api_v1_team_members_url, headers: @headers, params: params, as: :json

    alex = TeamMember.first
    assert_equal({ 'team_member' => alex.id }, response.parsed_body)
  end

  test ':create endpoint returns error for wrong group name' do
    params = {
      name: 'Alex Johnson',
      role: 'Board Member',
      group: 'intern'
    }

    post api_v1_team_members_url, headers: @headers, params: params, as: :json
    assert_response :unprocessable_entity
  end

  test ':create endpoint returns error for missing group field' do
    params = {
      name: 'Alex Johnson',
      role: 'Board Member'
    }

    post api_v1_team_members_url, headers: @headers, params: params, as: :json
    assert_response :unprocessable_entity
  end

  test ':update endpoint updates an existing TeamMember' do
    alex = create(:team_member, name: 'Alex Johnson')
    new_description = 'Has worked for a lot of good companies'
    new_image_src = 'images/new_image.jpg'
    new_role = 'Legislative Affairs'
    new_group = TeamMember::BOARD_GROUP_NAME
    params = {
      description: new_description,
      group: new_group,
      id: alex.id,
      image_src: new_image_src,
      name: alex.name,
      role: new_role,
    }

    put api_v1_team_member_url(alex.id), headers: @headers, params: params, as: :json

    alex = TeamMember.first
    assert_equal response.status, 200
    assert_equal alex.description, new_description
    assert_equal alex.group, new_group
    assert_equal alex.image_src, new_image_src
    assert_equal alex.role, new_role
  end

  test ':destroy endpoint destroys an existing TeamMember' do
    alex = create(:team_member, name: 'Alex Johnson')
    params = {
      id: alex.id,
      name: alex.name,
      role: alex.role
    }

    delete api_v1_team_member_url(alex.id), headers: @headers, params: params, as: :json

    assert_equal response.status, 200
    assert_equal TeamMember.count, 0
  end
end
