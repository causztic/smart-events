class SchedulesController < ApplicationController
  before_action :authenticate_user!
  def show
    #@events = user.sessions
    @events = []
  end
end
