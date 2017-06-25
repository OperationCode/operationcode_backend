module Api
  module V1
    class UsersController < ApplicationController

      def create
        user = User.new(user_params)

        if user.save
          UserMailer.welcome(user).deliver unless user.invalid?
          render json: user
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def verify
        verified = IdMe.verify! params[:access_token]

        Rails.logger.debug "Got verified status '#{verified}'"
        Rails.logger.debug "Updating user'#{current_user.inspect}'"
        current_user.update_attribute(:verified, verified)
        Rails.logger.debug "Updating user'#{User.last.inspect}'"
        render json: { status: :ok, verified: verified }
      rescue => e
        Rails.logger.debug "When verifying User id #{User.last.id} through ID.me, experienced this error: #{e}"
        render json: { status: :unprocessable_entity }, status: :unprocessable_entity
      end

      def user_params
        params.require(:user).permit(:email, :zip, :password, :first_name, :last_name, :mentor, :slack_name, :verified)
      end

    end
  end
end
