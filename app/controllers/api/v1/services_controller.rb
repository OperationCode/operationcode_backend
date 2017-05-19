module Api
  module V1
    class ServicesController < ApplicationController
      # TODO - authorization for services
      #before_action :authenticate_user!, only: :protected

      def index
        services = [
          Service.create(name: 'General Guidence - Voice Chat'),
          Service.create(name: 'General Guidence - Slack Chat'),
          Service.create(name: 'Pair Programming'),
          Service.create(name: 'Code Review'),
          Service.create(name: 'Mock Interview'),
          Service.create(name: 'Resume Review'),
        ]
        render json: services
      end

    end
  end
end
