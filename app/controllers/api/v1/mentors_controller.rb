class Api::V1::MentorsController < ApplicationController
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
