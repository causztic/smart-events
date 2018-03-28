class SchedulesController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }

  def update
    p params
  end
end
