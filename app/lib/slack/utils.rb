require 'slack/client'

module Slack
  # Utilities class for running methods and discovery on Client
  class Utils
    def email_is_registered?(email)
      users.any? { |user| user['profile']['email'] == email }
    end

    def username_is_registered?(username)
      users.any? { |user| user['name'] == username }
    end

    def client
      @slack_client ||= set_client
    end

    def users
      @users ||= set_users
    end

    private

    def set_users
      users_list = client.fetch_users_list
      users_list['members']
    end

    def set_client
      Slack::Client.new(
        subdomain: ENV.fetch('SLACK_SUBDOMAIN'),
        token:     ENV.fetch('SLACK_LEGACY_ADMIN_TOKEN')
      )
    end
  end
end
