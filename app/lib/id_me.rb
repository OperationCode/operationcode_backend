require "httparty"

class IdMe
  include HTTParty
  base_uri 'api.id.me'

  def self.verify!(access_token)
    options = { headers: headers }

    get("/api/public/v2/attributes.json?access_token=#{access_token}", options)
  end

  private

  def headers
    { "Accepts" => "application/json" }
  end
end
