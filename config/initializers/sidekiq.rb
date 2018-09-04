require 'sidekiq'

# Setting the ENV['DATABASE_URL'] explicitly to allow for use of a
# dynamic database host variable ENV['POSTGRES_HOST']
#
# @see https://github.com/mperham/sidekiq/wiki/Advanced-Options#rails-32-and-newer
#
Sidekiq.configure_server do |config|
  ENV['DATABASE_URL'] = ENV['POSTGRES_HOST'].present? ? ENV['POSTGRES_HOST'] : 'operationcode-psql'

  Rails.logger = Sidekiq::Logging.logger
  ActiveRecord::Base.logger = Sidekiq::Logging.logger
end
