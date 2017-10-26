module GitHub
  class Settings
    BACKEND = 'operationcode_backend'
    FRONTEND = 'operationcode_frontend'
    OC = 'operationcode'
    BOT = 'operationcode_bot'
    SLASHBOT = 'operationcode_slashbot'

    def self.owner
      'OperationCode'
    end

    def self.repositories
      [BACKEND, FRONTEND, OC, BOT, SLASHBOT]
    end

    # @see https://developer.github.com/v3/#user-agent-required
    #
    def self.user_agent
      owner
    end

    # Number of items that are returned per page, per request.
    # Max of 100.
    #
    # @see https://developer.github.com/v3/#pagination
    #
    def self.per_page
      100
    end

    def self.client_id
      OperationCode.fetch_secret_with(name: :git_hub_client_id)
    end

    def self.client_secret
      OperationCode.fetch_secret_with(name: :git_hub_client_secret)
    end

    # There are three ways to authenticate through GitHub's API v3.
    # Choices are: BASIC, O_AUTH_2_TOKEN, or O_AUTH_2_KEY_SECRET.
    #
    # This method sets the authentication level from constants in
    # GitHub::Authentication
    #
    # @see https://developer.github.com/v3/#authentication
    #
    def self.authentication_level
      GitHub::Authentication::O_AUTH_2_KEY_SECRET
    end
  end
end
