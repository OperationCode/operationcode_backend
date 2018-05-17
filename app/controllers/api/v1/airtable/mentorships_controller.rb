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

        def create
          verify_user!

          mentor_request = ::Airtable::Mentorship.new.create_mentor_request(mentorship_params)

          render json: mentor_request, status: :created
        rescue ::Airtable::Error => e
          render json: { error: e.message }, status: :unprocessable_entity
        end

        private

        def mentorship_params
          params.permit(
            :slack_user,
            :services,
            :skillsets,
            :additional_details,
            :mentor_requested
          )
        end

        def verify_user!
          raise ::Airtable::Error, 'User must be verified to request mentor services' unless current_user.verified?
        end
      end
    end
  end
end
