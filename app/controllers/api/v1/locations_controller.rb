module Api
  module V1
    class LocationsController < ApplicationController
      before_action :set_location, except: :create

      def create
        location = Location.create!(location_params)

        render json: { location: location.id }, status: :created
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def update
        @location.update!(location_params)

        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      def destroy
        @location.destroy!

        render json: { status: :ok }
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      private

      def set_location
        @location = Location.find_by(id: params[:id])
      end

      def location_params
        params.require(:location).permit(:code_school_id, :va_accepted, :address1, :address2, :city, :state, :zip)
      end
    end
  end
end
