class CoordinatorController < ApplicationController
  before_action :authenticate_user!
  
  def dashboard
    @unassigned_subjects = Subject.left_outer_joins(:instructors).where(users: { id: nil })
  end

end