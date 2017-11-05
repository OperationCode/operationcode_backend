require 'sidekiq'

Sidekiq.configure_server do |config|
  ENV['DATABASE_URL'] = ENV['POSTGRES_HOST'].present? ? ENV['POSTGRES_HOST'] : 'operationcode-psql'

  Rails.logger = Sidekiq::Logging.logger
  ActiveRecord::Base.logger = Sidekiq::Logging.logger
end
