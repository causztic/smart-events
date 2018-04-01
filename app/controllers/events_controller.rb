class EventsController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }
  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: "Successfully added event."
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :speaker_name, :date, :start_time, :end_time)
  end

end