module Api
  module V1
    class EventsController < ApiController
      def index
        render json: Event.all
      end

    end
  end
end
