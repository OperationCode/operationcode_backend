require 'test_helper'

class GitHub::AuthenticationTest < ActiveSupport::TestCase
  setup do
    GitHubStatistic.delete_all
    GitHubUser.delete_all

    @options = {
      query: {
        per_page: 100,
      },
      headers: {
        'Accepts' => 'application/vnd.github.v3+json',
        'User-Agent' => 'operationcode',
      },
    }

    GitHub::Settings.stubs(:authentication_level).returns(GitHub::Authentication::O_AUTH_2_KEY_SECRET)

    @instance = GitHub::Authentication.new(@options)
  end

  test 'initialize constructs the expected variable' do
    assert_equal @options, @instance.options
    assert_equal GitHub::Authentication::O_AUTH_2_KEY_SECRET, @instance.auth_level
  end

  test '#set_options returns the passed in options when Rails.env.prod? is false' do
    assert @options, @instance.set_options
  end

  test '#set_options merges the authenticated OAUTH_KEY options hash when Rails.env.prod? is true' do
    Rails.env.stubs(:prod?).returns(true)

    assert_equal @instance.set_options,
                 :query =>
                   {
                     :client_id => 'some random id',
                     :client_secret => 'some random key',
                     :per_page => 100
                   },
                 :headers =>
                   {
                     'Accepts' => 'application/vnd.github.v3+json',
                     'User-Agent' => 'operationcode'
                   }
  end

  test '#set_options merges the authenticated OAUTH_TOKEN options hash when Rails.env.prod? is true' do
    GitHub::Settings.stubs(:authentication_level).returns(GitHub::Authentication::O_AUTH_2_TOKEN)
    Rails.env.stubs(:prod?).returns(true)

    instance = GitHub::Authentication.new(@options)
    assert_equal instance.set_options,
                 :query =>
                   {
                     :per_page => 100
                   },
                 :headers =>
                   {
                     'Accepts' => 'application/vnd.github.v3+json',
                     'User-Agent' => 'operationcode',
                     'Authorization' => "Bearer #{GitHub::Settings.o_auth_2_token}"
                   }
  end
end
