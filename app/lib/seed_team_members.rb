class SeedTeamMembers
  BOARD_DATA_PATH = 'board_members.yml'.freeze
  TEAM_DATA_PATH = 'team_members.yml'.freeze
  class << self

    def from_yaml(file_name, group)
      members_seed_file = Rails.root.join('config', file_name)
      members = YAML.load_file(members_seed_file)
      members.map do |member|
        create_or_update(member, group)
      end
    end

    def seed_all
      seed_board
      seed_team
    end

    def seed_board
      from_yaml(
        BOARD_DATA_PATH,
        TeamMember::BOARD_GROUP_NAME
      )
    end

    def seed_team
      from_yaml(
        TEAM_DATA_PATH,
        TeamMember::TEAM_GROUP_NAME
      )
    end

    private

    def create_or_update(member, group)
      TeamMember.find_or_create_by!(name: member['name']) do |c|
        c.description = member['description'] if member['description']
        c.image_src = member['image_src'] if member['image_src']
        c.name = member['name'] if member['name']
        c.role = member['role'] if member['role']
        c.group = group
      end
    end
  end
end
