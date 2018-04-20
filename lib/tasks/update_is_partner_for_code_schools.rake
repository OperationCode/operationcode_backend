namespace :is_partner do
  desc "Updates column is_partner for code schools"
  task code_schools: :environment do
    schools = CodeSchools.all
    schools.is_partner = true
    schools.save
  end
end
