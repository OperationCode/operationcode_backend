module Api
  module V1
    class ResourcesController < ApplicationController
      before_action :authenticate_user!, except: [:index, :show]
      before_filter :set_resource, only: [:show, :update, :destroy]

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

      def create
        resource = Resource.create! resource_params

        render json: { resource: resource.id }, status: :created
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        @resource.update! resource_params
        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def destroy
        @resource.destroy!
        render json: { status: :ok }
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
