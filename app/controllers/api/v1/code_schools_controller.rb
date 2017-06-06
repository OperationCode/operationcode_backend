module Api
  module V1
    class CodeSchoolsController < ApplicationController
      def index
        render json: CodeSchools.all
      end
    end
  end
end
