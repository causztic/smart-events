class SchedulesController < ApplicationController
  before_action :authenticate_user!
  def show
    #@events = user.sessions
    @chats = ChatRoom.eager_load(:users).map {|cr| { id: cr.id, name: cr.user_name }} if current_user.coordinator?
    @chats = [ChatRoom.find_or_create_by(user: current_user)] if current_user.instructor?
  end

  def download
    # generate a calendar and download.
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
end
