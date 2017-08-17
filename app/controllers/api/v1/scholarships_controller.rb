module Api
  module V1
    class ScholarshipsController < ApplicationController
      def index
        render json: Scholarship.all
      end

      def show
        render json: Scholarship.find(params[:id])
      end
    end
  end
end
