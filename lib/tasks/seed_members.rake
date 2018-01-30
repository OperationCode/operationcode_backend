namespace :seed_team_members do
  desc 'Seed team members'
  task all: :environment

  task board: :environment do
    SeedTeamMembers.seed_board
  end

  task team: :environment do
    SeedTeamMembers.seed_team
  end
end
