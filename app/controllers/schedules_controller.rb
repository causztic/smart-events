class SchedulesController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }, except: [:subscription]

  def update
    @schedule, s = find_by_type
    if @schedule.update_attributes(s)
      render json: { status: "Successfully updated schedule." }, status: 200
    else
      render json: { status: @schedule.errors.to_json }, status: 400
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
    user = User.find(params[:schedule_id])
    user.sessions.includes(:subject, :location).each { |event| generate_cal_item(cal, event) }
    Event.all.includes(:location).each { |event| generate_cal_item(cal, event) } if user.student?
    p cal
    render plain: cal.to_ical
  end

  private
  def generate_cal_item cal, event
    e = cal.event
    e.dtstart     = event.start_datetime
    e.dtend       = event.end_datetime
    e.summary     = event.name
    e.description = event.description
    e.location    = event.location.roomname
  end

  def find_by_type
    return [Session.find(params[:id]), update_session] if params[:type] === 'session'
    [Event.find(params[:id]), update_event]
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
