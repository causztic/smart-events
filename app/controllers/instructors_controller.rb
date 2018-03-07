class InstructorsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @instructor = Instructor.friendly.find(params[:id])
  end

  def index
    @instructors = Instructor.all.select(:name, :avatar, :faculty, :research_area, :slug)
                   .order(:faculty, :name).chunk &:faculty
  end

end