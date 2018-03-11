module Api
  module V1
    class SocialUsersController < ApplicationController
      before_action :authenticate_user!, only: %i[update]

      # For social media logins, renders the appropriate `redirect_to` path depending on whether the user is registered.
      #
      # Requires that the ActionController::Parameters contain a :user key, with a nested :email key.
      # For example: { user: { email: "john@example.com" } }
      #
      # @return [String] A string of the user's redirect_to path
      # @see https://github.com/zquestz/omniauth-google-oauth2#devise
      #
      def show
        user = User.find_by(email: params.dig(:email));
        redirect_path = '/profile'

        if user.nil?
          redirect_path = '/social_login'
        end
        render json: { redirect_to: redirect_path }
      end

      # For social media logins, creates the user in the database if necessary,
      # then logs them in, and renders the appropriate `redirect_to` path depending on whether the user is logging in
      # for the first time.
      #
      # @return [String] A string of the user's redirect_to path
      # @return [Json] A serialied JSON object derived from current_user
      # @return [Token] A token that the frontend stores to know the user is logged in
      # @see https://github.com/OperationCode/operationcode_backend/blob/master/app/controllers/api/v1/sessions_controller.rb#L8-L20
      #
      def create
          @user, redirect_path = User.fetch_social_user_and_redirect_path(params.dig(:user))

          if @user.save
            sign_in @user, event: :authenticate_user
            render json: {
              token: @user.token,
              user: UserSerializer.new(current_user),
              redirect_to: redirect_path
            }
          else
            redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
          end
      end

      def social_user_params
        params.require(:user).permit(
          :email
        )
      end
    end
  end
end
