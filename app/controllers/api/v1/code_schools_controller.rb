module Api
  module V1
    class CodeSchoolsController < ApplicationController
      def index
        render json: CodeSchool.all
      end
      
      def create 
        @school = CodeSchool.new(params_school)
        
        if @school.save 
          render json: @school
        else 
          render json: { :errors => @school.errors.full_messages }
        end
      end
      
      def show 
        @school = CodeSchool.find(params[:id])
        if @school
          render json: @school
        else 
          render json: { :errors => @school.errors.full_messages }
        end
      end
      
      def update 
        @school = CodeSchool.find(params[:id])
        @school.update(params_school)
        if @school.save
          render json: @school
        else 
          render json: { :errors => @school.errors.full_messages }
        end
      end
      
      def destroy
        @school = CodeSchool.find(params[:id])
        if @school.destroy
          render json: { status: :ok }
        else 
          render json: { :errors => @school.errors.full_messages }
        end        
      end
      
      private       
      def params_school
        params.require(:code_school).permit(:name, :url, :logo, :full_time, :hardware_included, :has_online, :online_only)
      end
    end
  end
end
