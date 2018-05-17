namespace :meetup do
  desc 'Rake task to get Meetup API data'
  task :fetch => :environment do
    begin
      Meetup.new.add_events_to_database!
    rescue => e
      Rails.logger.error "When fetching and saving Meetup events, experienced this error: #{e}"
    end
  end
end
