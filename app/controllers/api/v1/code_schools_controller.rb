module Api
  module V1
    class CodeSchoolsController < ApiController
      def index
        render json: CodeSchools.all
      end

      def create
        school = CodeSchool.new(code_school_params)

        if school.save
          render json: school
        else
          render json: { errors: school.errors.full_messages }
        end
      end

      def show
        school = CodeSchool.find_by(id: params[:id])
        if school
          render json: school
        else
          render json: { error: 'No such record' }, status: :not_found
        end
      end

      def update
        school = CodeSchool.find(params[:id])
        if school.update(code_school_params)
          render json: school
        else
          render json: { errors: school.errors.full_messages }
        end
      end

      def destroy
        school = CodeSchool.find(params[:id])
        if school.destroy
          render json: { status: :ok }
        else
          render json: { errors: school.errors.full_messages }
        end
      end

      private

      def code_school_params
        params.require(:code_school).permit(:name, :url, :logo, :full_time, :hardware_included, :has_online, :online_only)
      end
    end
  end
end
