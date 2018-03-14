class SchedulesController < ApplicationController
  before_action :authenticate_user!
  def show
    #@events = user.sessions
    demo_events
  end

  def download
    # generate a calendar and download.
    demo_events
    cal = Icalendar::Calendar.new
    filename = "Class Schedule"

    if params[:format] == 'vcs'
      cal.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
      cal.version = '1.0'
      filename += '.vcs'
    else # ical
      cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
      cal.version = '2.0'
      filename += '.ics'
    end

    @events.each do |event|
      e = cal.event
      e.dtstart     = event[:start]
      e.dtend       = event[:end]
      e.summary     = event[:title]
      e.description = event[:title]
    end

    send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
  end


  private
  def demo_events
    @events = []
    test_subject_name = current_user.subjects.first.name;
    30.times do |t|
      @events << {
        id: t,
        title: test_subject_name,
        start: Time.now.beginning_of_day + 10.hours + (7 * t).days,
        end:  Time.now.beginning_of_day + 12.hours + (7 * t).days
      }
    end
  end

end
