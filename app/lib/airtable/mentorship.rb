module Airtable
  class Mentorship
    attr_reader :client

    def initialize
      @client = Airtable::Client.new
    end

    def mentor_request_data
      {
        mentors: mentors,
        services: services,
        skillsets: skillsets
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

    def services
      services = client.get_records_for('Services')

      services.map do |serive|
        {
          id: serive['id'],
          name: serive.dig('fields', 'Name')
        }
      end
    end

    def skillsets
      skillsets = client.get_records_for('Skillsets')

      skillsets.map do |skillset|
        {
          id: skillset['id'],
          name: skillset.dig('fields', 'Name')
        }
      end
    end
  end
end
