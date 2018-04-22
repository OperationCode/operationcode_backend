module Api
  module V1
    class SlackUsersController < ApiController
      before_action :authenticate_py_bot!

      def create
        raise "User id #{current_user.id} does not have a saved email address." unless current_user.email.present?

        SlackJobs::InviterJob.perform_now current_user.email

        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def access
        render json: { message: 'You have access!' }, status: :ok
      end

      private

      def authenticate_py_bot!
        auth = JsonWebToken.decode(auth_token)

        if auth['key'] == Rails.application.secrets.py_bot_auth_key
          true
        else
          render json: { errors: ["Auth token is incorrect"] }, status: :unauthorized
        end

      rescue JWT::ExpiredSignature
        render json: { errors: ["Auth token has expired"] }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { errors: ["Invalid auth token"] }, status: :unauthorized
      end

      def auth_token
        @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
      end
    end
  end
end
