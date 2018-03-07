class MainController < ApplicationController
  before_action :authenticate_user!
  def home
    @params = {}
    if current_user.coordinator?
      @empty_subjects = Subject.left_outer_joins(:lessons).where( lessons: { id: nil } )
      @params = { empty_subjects: @empty_subjects }
    end
  end
end