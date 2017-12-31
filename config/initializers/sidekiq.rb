require 'sidekiq'

# Setting the ENV['DATABASE_URL'] explicitly to allow for use of a
# dynamic database host variable ENV['POSTGRES_HOST']
#
# @see https://github.com/mperham/sidekiq/wiki/Advanced-Options#rails-32-and-newer
#
Sidekiq.configure_server do |config|
  ENV['DATABASE_URL'] = ENV['POSTGRES_HOST'].present? ? ENV['POSTGRES_HOST'] : 'operationcode-psql'
  database_url = ENV['DATABASE_URL']

  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
    # Note that as of Rails 4.1 the `establish_connection` method requires
    # the database_url be passed in as an argument. Like this:
    # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end

  Rails.logger = Sidekiq::Logging.logger
  ActiveRecord::Base.logger = Sidekiq::Logging.logger
end
