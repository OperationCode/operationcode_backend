ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'factory_girl'
require 'sidekiq/testing'
require 'vcr'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Rails.application.routes.url_helpers

  def authorization_headers(user)
    { 'Authorization': "bearer #{user.token}" }
  end

  # @see https://gist.github.com/mattbrictson/72910465f36be8319cde
  #
  # Monkey patch the `test` DSL to enable VCR and configure a cassette named
  # based on the test method. This means that a test written like this:
  #
  # class OrderTest < ActiveSupport::TestCase
  #   test "user can place order" do
  #     ...
  #   end
  # end
  #
  # will automatically use VCR to intercept and record/play back any external
  # HTTP requests using `cassettes/order_test/_user_can_place_order.yml`.
  #
  def self.test(test_name, &block)
    return super if block.nil?

    cassette = [name, test_name].map do |str|
      str.underscore.gsub(/[^A-Z]+/i, '_')
    end.join('/')

    super(test_name) do
      VCR.use_cassette(cassette) do
        instance_eval(&block)
      end
    end
  end
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
end

Geocoder.configure(lookup: :test)
Geocoder::Lookup::Test.set_default_stub(
  [{ 'latitude'   => -4,
     'longitude'  => -4,
     'address'    => 'a weird default, when real world accuracy does not matter',
     'state_code' => 'DEFAULT' }]
)
Geocoder::Lookup::Test.add_stub(
  '97201', [{ 'latitude' => 45.505603,
              'longitude' => -122.6882145,
              'address'    => 'real world result for the zip used in the user factory',
              'state_code' => 'OR' }]
)
