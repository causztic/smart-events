class EventsController < CoordinatorController

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
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
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to events_path, notice: "Successfully updated event."
    else
      render :new
    end
  end

  def destroy
    @event.delete
    redirect_to events_path, notice: "Successfully deleted event."
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :speaker_name, :date, :start_time, :end_time)
  end

end