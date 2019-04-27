module SlackService
  class Client
    include HTTParty

    base_uri ENV['SLACK_SERVICE_URL']

    attr_reader :headers

    def initialize
      bearer_token = "Bearer #{ENV['SLACK_SERVICE_AUTH_TOKEN']}"
      @headers = { Authorization: bearer_token }
    end

    def verify(email)
      response = self.class.get(
        '/verify',
        headers: headers,
        query: { email: email }
      )

      Rails.logger.info "Slack service #verify response: #{response.inspect}"

      return_value_for(response)
    end

    def invite(email)
      response = self.class.post(
        '/invite',
        headers: headers,
        body: { email: email }.to_json
      )

      Rails.logger.info "Slack service #invite response: #{response.inspect}"

      return_value_for(response)
    end

    private

    def response_json(response)
      response.present? ? response.parsed_response : {}
    end

    def return_value_for(response)
      json = response_json(response)
      case response.code
      when 200
        json
      else
        raise SlackService::Error, response.inspect
      end
    end
  end
end
