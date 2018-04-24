module Api
  module V1
    class TagsController < ApiController
      def index
        render json: ActsAsTaggableOn::Tag.all, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end
    end
  end
end
