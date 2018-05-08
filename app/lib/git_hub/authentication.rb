module GitHub
  class Authentication
    BASIC = 'basic_authentication'
    O_AUTH_2_TOKEN = 'o_auth_2_token'
    O_AUTH_2_KEY_SECRET = 'o_auth_2_key_secret'

    attr_reader :options, :auth_level

    def initialize(options)
      @options = options
      @auth_level = GitHub::Settings.authentication_level
    end

    def set_options
      return options unless Rails.env.prod?

      authentication_options.deep_merge options
    end

    private

    def authentication_options
      case auth_level
      when BASIC
        # tbd
      when O_AUTH_2_TOKEN
        o_auth_2_token_options
      when O_AUTH_2_KEY_SECRET
        key_secret_options
      end
    end

    def o_auth_2_token_options
      {
        headers: {
          'Authorization' => "Bearer #{GitHub::Settings.o_auth_2_token}"
        }
      }
    end

    def key_secret_options
      {
        query: {
          client_id: GitHub::Settings.client_id,
          client_secret: GitHub::Settings.client_secret,
        }
      }
    end
  end
end
