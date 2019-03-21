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
        subdomain: OperationCode.fetch_secret_with(name: :slack_subdomain),
        token:     OperationCode.fetch_secret_with(name: :slack_legacy_admin_token)
      )
    end
  end
end
