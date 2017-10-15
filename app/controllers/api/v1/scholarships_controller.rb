module Api
  module V1
    class ScholarshipsController < ApiController
      def index
        render json: Scholarship.all
      end

      def show
        scholarship = Scholarship.find_by(id: params[:id])
        if scholarship
          render json: scholarship
        else
          render json: { error: 'No such record' }, status: :not_found
        end
      end
    end
  end
end
