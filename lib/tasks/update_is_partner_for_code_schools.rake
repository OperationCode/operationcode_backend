namespace :is_partner do
  desc 'Updates column is_partner for code schools'
  task code_schools: :environment do
    is_partner_schools = [
                           'Bloc',
                           'Coder Camps',
                           'Code Platoon',
                           'The Flatiron School',
                           'Fullstack Academy',
                           'Launch School',
                           'Sabio',
                           'Startup Institute',
                           'Thinkful'
                          ]
                          
    schools = CodeSchool.where(name: is_partner_schools)

    schools.each do |school|
      next if school.is_partner?
      school.is_partner = true
      school.save
    end
  end
end
