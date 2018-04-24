namespace :is_partner do
  desc "Updates column is_partner for code schools"
  task code_schools: :environment do

    is_partner_schools = [
                          {name: "Bloc"},
                          {name: "Coder Camps"},
                          {name: "Code Platoon"},
                          {name: "The Flatiron School"},
                          {name: "Fullstack Academy"},
                          {name: "Launch School"},
                          {name: "Sabio"},
                          {name: "Startup Institute"},
                          {name: "Thinkful"},
                         ]

    is_parnter_school_name_array = is_partner_schools.map { |u| u[:name] }
    schools = CodeSchool.where(name: is_partner_school_name_array)

    schools.each do |school|
      next if school.is_partner?
      school.is_partner = true
      school.save
    end
  end
end
