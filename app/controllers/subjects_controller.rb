class SubjectsController < ApplicationController
  before_action :authenticate_user!
  def index
    @subjects = Subject.all.includes(:instructors)
  end

  def instructors
    @instructors = Subject.find(params[:subject_id]).instructors
    render json: @instructors
  end

  def show
    @subject = Subject.find_by(code: params[:id])
  end
end
