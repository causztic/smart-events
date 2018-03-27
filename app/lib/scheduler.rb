module Scheduler
  def self.generate student_pillar, term=0
    # generate a series of schedules based on the student pillar.
    raise "Pillars must be in #{::STUDENT_PILLARS}" if ::STUDENT_PILLARS.exclude? student_pillar

    subjects = Subject.find_by_sql("SELECT id, code, facility_hours,
          COUNT(s.student_id) AS students,
          COUNT(s.instructor_id) AS instructors,
          array_agg(s.instructor_id) FILTER (WHERE s.instructor_id IS NOT NULL) AS instructor_ids
          FROM subjects
          INNER JOIN subjects_users s on s.subject_id = subjects.id
          WHERE subjects.term_available = 0
          AND subjects.pillar IN (0,6)
          GROUP BY subjects.id;")

    locations = Location.all.select(:id, :name, :roomname, :classroom, :capacity).group_by &:classroom
    schedules = []
    current_time = @private.reset_week

    subjects.each do |subject|
      student_count = subject.attributes["students"].to_f
      instructor_count = subject.attributes["instructors"].to_f
      instructors = subject.attributes["instructor_ids"]
      # use the count and determine the number of sessions needed
      subject.facility_hours.each_pair do |location_name, hours|
        # assume that hours are < 3 hours right now.
        # count the number of lecturers.
        1.upto((student_count / locations[location_name][0].capacity).ceil) do |t|

          obj = { subject: subject.id,
            start_time: current_time,
            end_time: current_time + hours.hours,
            location: location_name,
            instructor: instructors[t % instructor_count]
          }

          # stagger the time if there are more sessions than instructors or if it is a lecture.
          # reset to next day if the next lesson will overshoot timing.
          current_time += hours.hours if ((t+1) % instructor_count == 0 || location_name == "lecture")
          current_time = @private.reset_day(current_time) + 1.day if ((current_time + hours.hours) > (current_time.beginning_of_day + 18.hours))
          # create a schedule for the current_time.
          # schedule = IceCube::Schedule.new(current_time, duration: hours * 60 * 60)
          # schedule.add_recurrence_rule IceCube::Rule.weekly
          # obj[:schedule] = schedule.to_hash

          index = t-1
          schedules[index].is_a?(Array) ? schedules[index] << obj : schedules[index] = [obj]
        end

        # after assigning the sessions for the particular subject, advance the time
        current_time += hours.hours
      end
    end

    # schedules.each do |schedule|
    #   p schedule
    # end

    schedules
  end

  @private = Module.new do
    def self.reset_week
      Date.today.beginning_of_week + 8.hours + 30.minutes
    end

    def self.reset_day date
      date.beginning_of_day + 8.hours + 30.minutes
    end

  end
end