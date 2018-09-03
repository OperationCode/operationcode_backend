require 'sidekiq'

# Setting the ENV['DATABASE_URL'] explicitly to allow for use of a
# dynamic database host variable ENV['POSTGRES_HOST']
#
# @see https://github.com/mperham/sidekiq/wiki/Advanced-Options#rails-32-and-newer
#
Sidekiq.configure_server do |config|
  ENV['DATABASE_URL'] = ENV['POSTGRES_HOST'].present? ? ENV['POSTGRES_HOST'] : 'operationcode-psql'
  # https://stackoverflow.com/questions/28412913/disable-automatic-retry-with-activejob-used-with-sidekiq
  # prevent excessive retries from some default status.
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::Server::RetryJobs, maxretries: 5
  end
  Rails.logger = Sidekiq::Logging.logger
  ActiveRecord::Base.logger = Sidekiq::Logging.logger
end
