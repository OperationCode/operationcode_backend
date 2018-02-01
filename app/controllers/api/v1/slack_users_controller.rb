module Api
  module V1
    class SlackUsersController < ApiController
      before_action :authenticate_user!

      def create
        raise "User id #{current_user.id} does not have a saved email address." unless current_user.email.present?

        SlackJobs::InviterJob.perform_now current_user.email

        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
