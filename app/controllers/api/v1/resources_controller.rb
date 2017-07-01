module Api
  module V1
    class ResourcesController < ApplicationController
      before_action :authenticate_user!
      before_filter :set_resource, only: :show

      def index
        resources = Resource.with_tags params[:tags]

        render json: resources, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def show
        render json: @resource, status: :ok
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

    private

      def resource_params
        params.require(:resource).permit(
          :name,
          :url,
          :category,
          :language,
          :paid,
          :notes,
          :votes_count
        )
      end

      def set_resource
        @resource = Resource.find params[:id]
      end
    end
  end
end
