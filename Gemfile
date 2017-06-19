#ruby=ruby-2.3.3
#ruby-gemset=operationcode_backend

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'devise'
gem 'geocoder'
gem 'gibbon'
gem 'jwt'
gem 'lograge'
gem 'logstash-event'
gem 'operationcode-airtable'
gem 'operationcode-slack'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '~> 5.0.2'
gem 'redis', '~> 3.0'
gem 'sentry-raven'
gem 'sidekiq'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'mocha'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'


