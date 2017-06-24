require "httparty"

class IdMe
  include HTTParty
  base_uri 'api.id.me'

  def self.verify!(access_token)
    options = { headers: headers }

    response = get("/api/public/v2/attributes.json?access_token=#{access_token}", options)

    fail response.body unless response.code == 200

    verified.body['verified'] == 'true' ? true : false
  end

private

  def self.headers
    { 'Accepts' => 'application/json' }
  end
end
