namespace :schools do
  desc 'Reads from the ./config/code_schools.yml and creates records in the database.'
  task populate: :environment do
    schools = YAML::load_file(File.join('./config', 'code_schools.yml'), 'r')
    schools.each do |school|
      begin
        object = CodeSchool.create!(
          name: school['name'],
          url: school['url'],
          logo: school['logo'],
          full_time: school['full_time'],
          hardware_included: school['hardware_included'],
          has_online: school['has_online'],
          online_only: school['online_only'],
          notes: school['notes']
          )
        school['locations'].each do |location|
          object.locations.create!(
            va_accepted: location['va_accepted'],
            address1: location['address1'],
            address2: location['address2'],
            city: location['city'],
            state: location['state'],
            zip: location['zip']
          )
        end
      rescue StandardError => e
        message = "Failed to create CodeSchool: #{e}"

        puts message
        Rails.logger.error message
      end

      p "Created #{CodeSchool.count} code schools"
      p "Created #{Location.count} locations"
    end
  end
end
