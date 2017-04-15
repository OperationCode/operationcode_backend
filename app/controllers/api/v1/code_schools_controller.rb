module Api
  module V1
    class CodeSchoolsController < ApplicationController
      def index
        code_schools = CodeSchools.new
        render json: { va_approved: code_schools.va_accepted, by_state: code_schools.by_state }
      end
    end
  end
end
