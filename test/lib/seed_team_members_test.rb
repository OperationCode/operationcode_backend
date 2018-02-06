require 'test_helper'

class SeedTeamMembersTest < ActiveSupport::TestCase
  test ':all creates correct count of records' do
    board_seed_file = Rails.root.join('config', SeedTeamMembers::BOARD_DATA_PATH)
    board = YAML.load_file(board_seed_file)
    team_seed_file = Rails.root.join('config', SeedTeamMembers::TEAM_DATA_PATH)
    team = YAML.load_file(team_seed_file)
    SeedTeamMembers.seed_all
    assert_equal board.count + team.count, TeamMember.count
  end

  test 'overwrites if attrs are changed' do
    example = {
      'description' => 'test description',
      'image_src' => 'images/test.jpg',
      'name' => 'test name',
      'role' => 'test role'
    }
    YAML.stubs(:load_file).returns([example])
    SeedTeamMembers.seed_board
    assert_equal TeamMember.first.description, example['description']
    assert_equal TeamMember.first.name, example['name']
    assert_equal TeamMember.first.role, example['role']
    assert_equal TeamMember.first.group, TeamMember::BOARD_GROUP_NAME
    new_example = {
      'description' => 'new test description',
      'image_src' => 'images/test.jpg',
      'name' => 'test name',
      'role' => 'test role'
    }
    YAML.stubs(:load_file).returns([new_example])
    SeedTeamMembers.seed_board
    assert_equal TeamMember.first.description, example['description']
    assert_equal TeamMember.first.name, example['name']
    assert_equal TeamMember.first.role, example['role']
    assert_equal TeamMember.first.group, TeamMember::BOARD_GROUP_NAME
    assert_equal 1, TeamMember.count
  end

  test 'creates new record if name is changed' do
    example = {
      'description' => 'test description',
      'image_src' => 'images/test.jpg',
      'name' => 'test name',
      'role' => 'test role'
    }
    YAML.stubs(:load_file).returns([example])
    SeedTeamMembers.seed_board
    assert_equal TeamMember.first.description, example['description']
    assert_equal TeamMember.first.name, example['name']
    assert_equal TeamMember.first.role, example['role']
    assert_equal TeamMember.first.group, TeamMember::BOARD_GROUP_NAME
    example['name'] = 'new test name'
    SeedTeamMembers.seed_board
    assert_equal 2, TeamMember.count
  end
end
