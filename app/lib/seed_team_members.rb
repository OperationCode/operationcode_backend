class SeedTeamMembers
  BOARD_DATA_PATH = 'board_members.yml'.freeze
  TEAM_DATA_PATH = 'team_members.yml'.freeze

  def self.from_yaml(file_name, group)
    members_seed_file = Rails.root.join('config', file_name)
    members = YAML::load_file(members_seed_file)
    members.map do |member|
      TeamMember.find_or_create_by!(
        member.merge!("group" => group)
      )
    end
  end

  def self.seed_all
    seed_board
    seed_team
  end

  def self.seed_board
    from_yaml(
      BOARD_DATA_PATH,
      TeamMember::BOARD_GROUP_NAME
    )
  end

  def self.seed_team
    from_yaml(
      TEAM_DATA_PATH,
      TeamMember::TEAM_GROUP_NAME
    )
  end
end
