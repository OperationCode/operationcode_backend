require 'sidekiq'

Sidekiq.configure_server do |config|
  Rails.logger = Sidekiq::Logging.logger
  ActiveRecord::Base.logger = Sidekiq::Logging.logger
end
