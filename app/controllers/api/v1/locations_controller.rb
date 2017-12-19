module Api
  module V1
    class LocationsController < ApplicationController
      before_action :set_school
      def create
        @school.locations.build(location_params)
        if @school.save
          render json: @school
        else
          render json: { errors: @school.errors.full_messages }
        end
      end

      def update
        location = Location.find(params[:id])
        if location.update(location_params)
          render json: location
        else
          render json: { errors: location.errors.full_messages }
        end
      end

      def destroy
        location = Location.find(params[:id])
        render json: location ? { status: :ok } : { errors: location.errors.full_messages }
      end

      private

      def set_school
        @school = CodeSchool.find(params[:code_school_id])
      end

      def location_params
        params.require(:location).permit(:va_accepted, :address1, :address2, :city, :state, :zip)
      end
    end
  end
end
