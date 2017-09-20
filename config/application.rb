require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OperationcodeBackend
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.active_job.queue_adapter = :sidekiq
    config.log_level = :debug

    config.logger = Logger.new(STDOUT)
    config.lograge.enabled = true

    config.secret_path = Rails.root.join('run/secrets')
    
    Raven.configure do |config|
      config.dsn = 'https://d85c1b1efbd54287996ab632fb279cc7:9a90b74c47b24de389fcc5971b047c4c@sentry.io/219717'
    end
  end
end
