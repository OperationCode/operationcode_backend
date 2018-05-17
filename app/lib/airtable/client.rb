module Airtable
  class Client
    include HTTParty

    attr_reader :base_id, :headers, :base_url

    def initialize
      api_key   = Rails.application.secrets.airtable_api_key
      base_id   = Rails.application.secrets.airtable_base_id
      @headers  = { 'Authorization' => "Bearer #{api_key}" }
      @base_url = "https://api.airtable.com/v0/#{base_id}/"
    end

    # Fetches all of the records for the passed Airtable
    #
    # @param table [String] Name of the table in Airtable
    # @return [Hash] The parsed_response from Airtable
    #
    def get_records_for(table)
      response = HTTParty.get(url_for(table), headers: headers)

      return_value_for(response)
    end

    # Creates a new record in the passed Airtable
    #
    # @param table [String] Name of the table in Airtable
    # @param body [JSON] JSON string of request body attributes
    # @return [Hash] The parsed_response from Airtable
    #
    def post_record(table, body)
      response = HTTParty.post(
        url_for(table),
        headers: update_headers,
        body: body
      )

      return_value_for(response)
    end

    private

    def url_for(table)
      base_url + escaped(table)
    end

    # URL-encodes the passed string for cases where the string has spaces
    #
    # @param url_string [String] a URL string
    # @return [String] String where any spaces are URL-encoded
    # @example escaped('Mentor Request') => 'Mentor%20Request'
    # @see http://ruby-doc.org/stdlib-2.3.3/libdoc/uri/rdoc/URI/Escape.html
    #
    # rubocop:disable Lint/UriEscapeUnescape
    def escaped(url_string)
      URI.escape url_string
    end
    # rubocop:enable Lint/UriEscapeUnescape

    # If the Airtable rate limit is reached, a 429 status code is returned
    # @see https://airtable.com/appSqQz7spgg0I1jQ/api/docs#curl/ratelimits
    #
    def return_value_for(response)
      case response.code
      when 200
        response.parsed_response
      when 429
        raise Airtable::Error, 'Exceeded Airtable rate limit. Wait 30 seconds for subsequent requests.'
      else
        raise Airtable::Error, response.parsed_response
      end
    end

    def update_headers
      headers.merge(
        'Content-Type' => 'application/json'
      )
    end
  end
end
