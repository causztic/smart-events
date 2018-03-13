class StudentController < ApplicationController
  before_action -> { authenticate_role!(Student) }

  def dashboard; end

  def subjects
    @subjects = Subject.includes(:instructors).joins(:students)
                       .where("subjects_users.student_id = ?", current_user)
  end
end
