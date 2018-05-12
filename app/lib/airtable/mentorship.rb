module Airtable
  class Mentorship
    attr_reader :client

    def initialize
      @client = Airtable::Client.new
    end

    # Fetches all the records from the mentors, services, and skillsets Airtables,
    # and re-formats the data into a custom hash
    #
    # @return [Hash] Hash of mentor, services, and skillsets data
    #
    def mentor_request_data
      {
        mentors: data_for('Mentors', name_key: 'Full Name'),
        services: data_for('Services'),
        skillsets: data_for('Skillsets')
      }
    end

    # Creates a new mentor request record in the Mentor Request Airtable
    #
    # @param body [Hash] Hash of mentor request attributes
    # @return [Hash] Hash of the newly created mentor request Airtable record
    #
    def create_mentor_request(body)
      request_body = {
        'fields' => {
          'Slack User' => body[:slack_user],
          'Service' => format_for_posting(body[:services]),
          'Skillsets' => format_for_posting(body[:skillsets]),
          'Additional Details' => body[:additional_details],
          'Mentor Requested' => format_for_posting(body[:mentor_requested])
        }
      }.to_json

      client.post_record('Mentor Request', request_body)
    end

    private

    def data_for(table, name_key: 'Name')
      records = client.get_records_for(table)

      records['records'].map do |record|
        {
          id: record['id'],
          name: record.dig('fields', name_key)
        }
      end
    end

    # Converts a comman separated string into an array of strings
    #
    # @param data_string [String] Comma separated strings of data
    # @return [Array] An array of stripped strings
    #
    def format_for_posting(data_string)
      data_string.split(',').map(&:strip)
    end
  end
end
