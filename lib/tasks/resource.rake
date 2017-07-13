namespace :resource do
  desc "Initially seeds the database with OC's resources"
  task initial_seeding: :environment do
    config    = Rails.root + 'config/resources.yml'
    resources = YAML.load_file(config)

    resources.each do |resource|
      begin
        Resource.create!(
          name: resource['name'],
          url: resource['url'],
          category: resource['category'],
          language: resource['language'],
          paid: resource['paid'],
          notes: resource['notes']
        )
      rescue => e
        Rails.logger.debug "When creating a Resource record for #{resource}, experienced this error: #{e}"
      end
    end
  end
end
