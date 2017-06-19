module Api
  module V1
    class EventsController < ApplicationController
      def index
        render json: Event.all
      end

    end
  end
end