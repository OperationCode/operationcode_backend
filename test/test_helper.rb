ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'factory_girl'
require 'vcr'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Rails.application.routes.url_helpers

  def authorization_headers(user)
    { 'Authorization': "bearer #{user.token}" }
  end
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
end

class ActiveSupport::TestCase
  def self.test(test_name, &block)
    return super if block.nil?

    cassette = [name, test_name].map do |str|
      str.underscore.gsub(/[^A-Z]+/i, "_")
    end.join("/")

    super(test_name) do
      VCR.use_cassette(cassette) do
        instance_eval(&block)
      end
    end
  end
end
