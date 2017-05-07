module Api
  module V1
    class UsersController < ApplicationController
      def create
        generated_password = Devise.friendly_token.first(8)
        user = User.new(user_params.merge(password: generated_password))

        if user.save
          render json: user
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :zip)
      end
    end
  end
end
