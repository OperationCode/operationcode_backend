ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Rails.application.routes.url_helpers

  def authorization_headers(user)
    { 'Authorization': "bearer #{user.token}" }
  end

end
