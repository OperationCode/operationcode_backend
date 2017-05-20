class Api::V1::MentorsController < ApplicationController
  before_action :authenticate_user!

  def index
    mentors = User.mentors
    render json: mentors
  end

end
