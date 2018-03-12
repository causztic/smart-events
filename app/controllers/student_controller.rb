class StudentController < ApplicationController
  before_action -> { authenticate_role!(Student) }
  
  def dashboard
  end

  def subjects
    @subjects = Subject.left_outer_joins(:instructors).where("subjects_users.student_id = ?", current_user)
  end

end

# Subject.left_outer_joins(:instructors).where(users: { id: nil })