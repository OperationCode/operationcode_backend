require 'sidekiq'
require 'sidekiq-cron'

schedule_file = 'config/job_schedule.yml'

Sidekiq.configure_server do |config|
  # https://stackoverflow.com/questions/28412913/disable-automatic-retry-with-activejob-used-with-sidekiq
  # prevent excessive retries from some default status.
  config.death_handlers << lambda { |job, e|
    # thanks rob for the nice message
    evt = Raven::Event.new(message: "#{job['class']} #{job['jid']} done run outta tries.")
    Raven.send_event(evt)
  }
  Rails.logger = Sidekiq::Logging.logger
  ActiveRecord::Base.logger = Sidekiq::Logging.logger

  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
end
