class InstructorController < ApplicationController
  before_action -> { authenticate_role!(Instructor) }
  
  def dashboard
  end

end