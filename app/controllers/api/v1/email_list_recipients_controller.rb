module Api
  module V1
    class EmailListRecipientsController < ApplicationController
      def create
        raise "Invalid email address: #{permitted_params[:email]}" unless valid_email?

        AddUserToSendGridJob.perform_later(guest)

        render json: { email: permitted_params[:email], guest: true }, status: :created
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

    private

      def permitted_params
        params.permit(:email)
      end

      # Guest is a Struct.  ActiveJob does not support the passing of Structs
      # as an argument. An ActiveJob::SerializationError < ArgumentError is raised.
      #
      # It does permit Arrays.  As such, the Struct is being passed within an Array.
      #
      # @see http://api.rubyonrails.org/classes/ActiveJob/SerializationError.html
      #
      def guest
        [SendGridClient::Guest.user(permitted_params[:email])]
      end

      def valid_email?
        params[:email] =~ User::VALID_EMAIL
      end
    end
  end
end
