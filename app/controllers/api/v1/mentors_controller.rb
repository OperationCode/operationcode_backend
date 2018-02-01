module Api
  module V1
    class MentorsController < ApplicationController
      before_action :authenticate_user!

      def index
        mentors = User.mentors
        render json: mentors
      end

      def show
        mentor = User.mentors.find(params[:id])
        render json: MentorSerializer.new(mentor)
      end

    end
  end
end
