require 'test_helper'

class GitHub::AuthenticationTest < ActiveSupport::TestCase
  setup do
    GitHubStatistic.delete_all
    GitHubUser.delete_all

    @options =  {
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

  test "initialize constructs the expected variable" do
    assert @instance.options == @options
    assert @instance.auth_level == GitHub::Authentication::O_AUTH_2_KEY_SECRET
  end

  test "#set_options returns the passed in options when Rails.env.prod? is false" do
    assert @instance.set_options == @options
  end

  test "#set_options merges the authenticated options hash when Rails.env.prod? is true" do
    Rails.env.stubs(:prod?).returns(true)

    assert @instance.set_options == {
      :query =>
        {
          :client_id => "fake_git_hub_client_id",
          :client_secret => "fake_git_hub_client_secret",
          :per_page => 100
        },
      :headers =>
        {
          "Accepts" => "application/vnd.github.v3+json",
          "User-Agent" => "operationcode"
        }
      }
  end
end
