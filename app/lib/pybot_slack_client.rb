class PybotSlackClient
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

    response.parsed_response
  end

  def invite(email)
    response = self.class.post(
      '/invite',
      headers: headers,
      body: { email: email }.to_json
    )

    response.parsed_response
  end
end
