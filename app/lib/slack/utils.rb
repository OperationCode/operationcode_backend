require 'slack/client'

module Slack
  # Utilities class for running methods and discovery on Client
  class Utils
    def email_is_registered?(email)
      user_response = client.lookupByEmail(email)
      user_response['ok']
    end

    def client
      @slack_client ||= set_client
    end

    private

    def set_client
      Slack::Client.new(
        subdomain: ENV.fetch('SLACK_SUBDOMAIN'),
        token:     ENV.fetch('SLACK_LEGACY_ADMIN_TOKEN') # admin token required to invite
      )
    end
  end
end
