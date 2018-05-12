require 'httparty'

class IdMe
  include HTTParty
  base_uri 'api.id.me'

  private_class_method :headers

  def self.verify!(access_token)
    options = { headers: headers }

    response = get("/api/public/v2/attributes.json?access_token=#{access_token}", options)

    verified = response.body['verified'] == 'verified' ? true : false

    fail response.body if !verified

    verified
  end

  def self.headers
    { 'Accepts' => 'application/json' }
  end
end
