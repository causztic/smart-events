class InstructorController < ApplicationController
  before_action -> { authenticate_role!(Instructor) }

  def dashboard; end
  def preferences; end

  def subjects
    @subjects = current_user.subjects
  end
end
