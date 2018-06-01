module Api
  module V1
    class JobsController < ApiController
      def index
        render json: Job.all, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
