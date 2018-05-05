require "httparty"

module Airtable
  class Client
    include HTTParty
    base_uri 'api.airtable.com/v0'

    attr_reader :base_id, :headers

    def initialize
      api_key  = Rails.application.secrets.airtable_api_key
      @base_id = Rails.application.secrets.airtable_base_id
      @headers = { :Authorization => "Bearer #{api_key}"}
    end

    def get_records_for(table)
      response = self.class.get("/#{base_id}/#{table}", headers: headers)

      return_value_for(response)
    end

    private

    # If the Airtable rate limit is reached, a 429 status code is returned
    # @see https://airtable.com/appSqQz7spgg0I1jQ/api/docs#curl/ratelimits
    #
    def return_value_for(response)
      case response.code
      when 200
        response.parsed_response['records']
      when 429
        raise Airtable::Error, 'Exceeded Airtable rate limit. Wait 30 seconds for subsequent requests.'
      else
        raise Airtable::Error, response.parsed_response
      end
    end
  end
end
