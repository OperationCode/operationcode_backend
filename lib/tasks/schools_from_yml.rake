namespace :schools_from_yml do
  desc "This reads from the code_schools.yml file and creates records in the database."
  task populate_schools: :environment do 
    schools =  YAML::load_file(File.join("./config", "code_schools.yml"), "r")    
    schools.each do |school, value|
      object = CodeSchool.new(
          name: school["name"], 
          url: school["url"], 
          logo: school["logo"], 
          full_time: school["full_time"],
          hardware_included: school["hardware_included"],
          has_online: school["has_online"],
          online_only: school["online_only"]
        )
        object.save
        locations = school["locations"].each do |location|
          object.locations.new(
            va_accepted: location["va_accepted"],
            address1: location["address1"],
            address2: location["address2"],
            city: location["city"],
            state: location["state"],
            zip: location["zip"]
          )
        object.save
        end
    end
  end
end
