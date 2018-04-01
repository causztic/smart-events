class SchedulesController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }, except: [:subscription]

  def update
    s = find_by_type
    if @schedule.update_attributes(s)
      render json: { status: "Successfully updated schedule." }, status: 200
    else
      render json: { status: schedule.errors.to_json }, status: 400
    end
  end

  def batch_update
    diff = params[:difference] / 1000
    Session.where(session_group: params[:group]).find_each do |session|
      unless (session.update_attributes(start_time: session.start_time - diff, end_time: session.end_time - diff))
        render json: { status: session.errors.to_json }, status: 400 and return
      end
    end
    render json: { status: "Successfully updated sessions." }, status: 200
  end

  def regenerate
    Scheduler.generate :Freshmore
    redirect_to coordinator_schedules_path
  end

  def subscription
    # generate a calendar and download.
    cal = Icalendar::Calendar.new
    cal.x_wr_calname = "Class Schedule"

    User.find(params[:schedule_id]).sessions.includes(:subject, :location).each do |event|
      e = cal.event
      e.dtstart     = event.start_time
      e.dtend       = event.end_time
      e.summary     = event.subject.name
      e.description = event.subject.description
      e.location    = event.location.roomname
    end

    p cal

    render plain: cal.to_ical
  end

  private
  def find_by_type
    if params[:type] === 'session'
      @schedule = Session.find(params[:id])
      s = update_session
    else
      @schedule = Event.find(params[:id])
      s = update_event
    end
  end

  def update_session
    {
      start_time: params[:start_time].to_datetime + 8.hours,
      end_time: params[:end_time].to_datetime + 8.hours
    }
  end

  def update_event
    {
      date: params[:start_time].to_date.beginning_of_day,
      start_time: params[:start_time].to_datetime + 8.hours,
      end_time: params[:end_time].to_datetime + 8.hours
    }
  end

end
