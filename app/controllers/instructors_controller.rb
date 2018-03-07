class InstructorsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @instructor = Instructor.friendly.find(params[:id])
    @subjects = @instructor.subjects
  end
end