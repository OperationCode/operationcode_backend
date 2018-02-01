module Api
  module V1
    class EmailListRecipientsController < ApiController
      def create
        raise "Invalid email address: #{permitted_params[:email]}" unless valid_email?

        AddGuestToSendGridJob.perform_later(permitted_params[:email])

        render json: { email: permitted_params[:email], guest: true }, status: :created
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

    private

      def permitted_params
        params.permit(:email)
      end

      def valid_email?
        params[:email] =~ User::VALID_EMAIL
      end
    end
  end
end
