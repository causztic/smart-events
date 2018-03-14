class SchedulesController < ApplicationController
  before_action :authenticate_user!
  def show
    #@events = user.sessions
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
