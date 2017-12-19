module Api
  module V1
    class LocationsController < ApplicationController
      before_action :set_location, only: [:update, :destroy]

      def create
        @school = CodeSchool.find(params[:code_school_id])
        @school.locations.build(location_params)
        if @school.save
          render json: @school
        else
          render json: { errors: @school.errors.full_messages }
        end
      end

      def update
        render json: @location.update(location_params) ? @location : { errors: @location.errors.full_messages }
      end

      def destroy
        render json: @location.destroy ? { status: :ok } : { errors: @location.errors.full_messages }
      end

      private

      def set_location
        @location = Location.find(params[:id])
      end

      def location_params
        params.require(:location).permit(:va_accepted, :address1, :address2, :city, :state, :zip)
      end
    end
  end
end
