require 'slack/client'

module Slack
  # Utilities class for running methods and discovery on Client
  class Utils
    def email_is_registered(email)
      client.validate_user_email(email: email)
    end

    def client
      @slack_client ||= set_client
    end

    private

    def set_client
      Slack::Client.new(
        subdomain: ENV['SLACK_SUBDOMAIN'],
        token:     ENV['SLACK_TOKEN']
      )
    end
  end
end
