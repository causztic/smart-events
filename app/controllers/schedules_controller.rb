class SchedulesController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }, except: [:subscription]

  def update
    session = Session.find(params[:id])
    s = {
      start_time: params[:start_time].to_datetime + 8.hours,
      end_time: params[:end_time].to_datetime + 8.hours,
    }
    if session.update_attributes(s)
      render json: { status: 'Successfully updated session.' }, status: 200
    else
      render json: { status: session.errors.to_json }, status: 400
    end
  end

  def regenerate
    Scheduler.generate :Freshmore
    redirect_to coordinator_schedules_path
  end

  def subscription
    # generate a calendar and download.
    cal = Icalendar::Calendar.new
    cal.x_wr_calname = 'Class Schedule'

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

end
