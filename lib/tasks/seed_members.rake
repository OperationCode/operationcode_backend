namespace :seed_team_members do
  desc 'Seed team members'
  task all: :environment do
    SeedTeamMembers.seed_all
  end

  task board: :environment do
    SeedTeamMembers.seed_board
  end

  task team: :environment do
    SeedTeamMembers.seed_team
  end

  task reseed_all: :environment do
    SeedTeamMembers.clean_seed
  end
end
