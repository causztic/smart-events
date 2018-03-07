class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    @params = {}
    if current_user.coordinator?
      unassigned_subjects = Subject.left_outer_joins(:instructors).where(users: { id: nil })
      @params = { unassigned_subjects: unassigned_subjects }
    end
  end
end