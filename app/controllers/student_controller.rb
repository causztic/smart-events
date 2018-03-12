class StudentController < ApplicationController
  before_action -> { authenticate_role!(Student) }
  
  def dashboard
  end

end