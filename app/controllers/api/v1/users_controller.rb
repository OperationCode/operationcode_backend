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

      private

      def user_params
        params.require(:user).permit(:email, :zip, :password, :first_name, :last_name, :mentor, :slack_name)
      end

    end
  end
end
