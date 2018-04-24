module Api
  module V1
    class EventsController < ApiController
      def index
        render json: Event.all, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
