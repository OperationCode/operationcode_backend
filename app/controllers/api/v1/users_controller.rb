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

        # FIXME use current user
        #current_user.update! verified: verified

        Rails.logger.debug "Got verified status '#{verified}'"
        Rails.logger.debug "Updating user'#{User.last.inspect}'"

        User.last.update_attribute(:verified, verified)
        render json: { status: :ok, verified: verified }
      rescue => e
        Rails.logger.debug "When verifying User id #{User.last.id} through ID.me, experienced this error: #{e}"
        render json: { status: :unprocessable_entity }, status: :unprocessable_entity
      end

      private

      def user_params
        params.require(:user).permit(:email, :zip, :password, :first_name, :last_name, :mentor, :slack_name, :verified)
      end

    end
  end
end
