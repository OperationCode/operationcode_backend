module Api
  module V1
    class SlackUsersController < ApiController
      before_action :authenticate_py_bot!
      before_action :set_slack_user, only: [:update]

      def create
        user = User.find_by(email: params[:slack_email])

        ActiveRecord::Base.transaction do
          slack_user = SlackUser.new slack_user_params
          slack_user.user_id = user.id unless user.nil?
          slack_user.save!

          render json: { action: generate_client_action(user, params[:slack_email]), slack_user: slack_user.id }, status: :created
        end
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        user = @slack_user.nil? || @slack_user.user_id.nil? ? nil : User.find(@slack_user.user_id)
        ActiveRecord::Base.transaction do
          @slack_user.update! params.permit(:slack_email)

          render json: { action: generate_client_action(user, params[:slack_email]), slack_user: @slack_user.id }, status: :created
        end
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
        elsif auth.dig(:errors).present?
          render json: { errors: auth.dig(:errors) }, status: :unauthorized
        else
          render json: { errors: ['Auth token is invalid'] }, status: :unauthorized
        end
      end

      def auth_token
        @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
      end

      def generate_client_action(user, email)
        user.nil? || user.email != email ? 'request_account_verification' : 'none'
      end

      def slack_user_params
        params.permit(
          :slack_id,
          :slack_name,
          :slack_real_name,
          :slack_display_name,
          :slack_email
        )
      end

      def set_slack_user
        @slack_user = SlackUser.find params[:id]
      end
    end
  end
end
