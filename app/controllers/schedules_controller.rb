class SchedulesController < ApplicationController

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
