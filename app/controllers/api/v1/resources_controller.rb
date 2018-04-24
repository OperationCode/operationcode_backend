module Api
  module V1
    class ResourcesController < ApiController
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
        ActiveRecord::Base.transaction do
          resource = Resource.new resource_params
          resource.tag_list.add(params[:tags], parse: true) if params[:tags].present?
          resource.save!

          render json: { resource: resource.id, tags: resource.tags.map(&:name) }, status: :created
        end
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        ActiveRecord::Base.transaction do
          @resource.update! resource_params
          update_tags!

          render json: { resource: @resource.id, tags: @resource.tags.map(&:name) }, status: :ok
        end
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
        params.permit(
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

      def update_tags!
        old_tags = @resource.tags.map(&:name)

        @resource.tag_list.remove old_tags
        @resource.tag_list.add(params[:tags], parse: true) if params[:tags].present?

        @resource.save!
        @resource.reload
      end
    end
  end
end
