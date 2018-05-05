module Api
  module V1
    module Airtable
      class MentorshipsController < ApiController
        before_action :authenticate_user!

        def index
          mentorship_data = ::Airtable::Mentorship.new.mentor_request_data

          render json: mentorship_data, status: :ok
        rescue ::Airtable::Error => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
      end
    end
  end
end
