class EventsController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }
  def new
    @event = Event.new
  end

  def create
  end

  def update
  end

  def destroy
  end

end