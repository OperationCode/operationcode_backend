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

    private

    def mentors
      mentors = client.get_records_for('Mentors')

      mentors.map do |mentor|
        {
          id: mentor['id'],
          full_name: mentor.dig('fields', 'Full Name')
        }
      end
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

    end
  end
end
