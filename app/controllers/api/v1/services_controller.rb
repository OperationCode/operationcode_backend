module Api
  module V1
    class ServicesController < ApplicationController
      # TODO - authorization for services
      #before_action :authenticate_user!, only: :protected

      def index
        services = [
          'General Guidence - Voice Chat',
          'General Guidence - Slack Chat',
          'Pair Programming',
          'Code Review',
          'Mock Interview',
          'Resume Review',
        ]
        render json: services
      end

    end
  end
end
