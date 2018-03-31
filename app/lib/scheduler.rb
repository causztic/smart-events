module Scheduler
  def self.generate student_pillar, term=0
    # generate a series of schedules based on the student pillar.
    Session.delete_all
    SessionsUser.delete_all
    Session.connection.execute('ALTER SEQUENCE sessions_id_seq RESTART WITH 1')
    SessionsUser.connection.execute('ALTER SEQUENCE sessions_users_id_seq RESTART WITH 1')

    raise "Pillars must be in #{::STUDENT_PILLARS}" if ::STUDENT_PILLARS.exclude? student_pillar

    # prepare required data
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
    schedules = {}
    max_cohort_size = 0

    locations.each_key do |key|
      schedules[key] = []
    end

    session_id = 0

    subjects.each do |subject|
      student_count = subject.attributes["students"].to_f
      instructor_count = subject.attributes["instructors"].to_f
      instructors = subject.attributes["instructor_ids"]
      # use the count and determine the number of sessions needed
      subject.facility_hours.each_pair do |location_name, hours|
        size = (student_count / locations[location_name][0].capacity).ceil
        max_cohort_size = size if size > max_cohort_size

        1.upto(size) do |t|
          hour_blocks = (hours.to_f / 3).ceil
          # we must ensure that each session cannot be too long
          hour_blocks.times do |d|
            schedules[location_name] << {
              subject_id: subject.id,
              location_id: locations[location_name][t % locations[location_name].length].id,
              duration: hours.to_f / hour_blocks,
              instructor_id: instructors[t % instructor_count] }
            end
        end
      end
    end

    <<-DOC
    the schedules are now the required minimum number of sessions needed to be conducted.
    they have already been assigned to instructors.
    we now need to assign them class by class.
    DOC

    cohort_sessions = Array.new(max_cohort_size) {|s| [] }
    freshmores = Student.freshmores
    # we go through by settling in order of capacity.
    %w(lecture classroom lab think_tank).each do |location_type|
      schedules[location_type].group_by {|s| s[:subject_id] }.each_value do |value|
        f = freshmores.in_groups(value.count, false)
        value.each_with_index do |session, index|
          session[:students] = f[index] # split the students up based on the number of sessions in that area.
        end
        # fill up sessions
        if value.count <= max_cohort_size
          cohort_sessions.each_slice(max_cohort_size / value.count).with_index do |session, index|
            session.each { |s| s.push(value[index]) }
          end
        else
          index = 0
          cohort_sessions.each do |session|
            (value.count / max_cohort_size).times do |t|
              session.push(value[index])
              index += 1
            end
          end
        end
      end
    end

    cohort_sessions.each do |cohort|
      current_time = @private.reset_week
      running_hours = 0
      cohort.each_with_index do |session, i|
        if session[:start_time].nil? # don't modify sessions that have times already set
          session[:day] = current_time.wday
          session[:start_time] = current_time
          session[:end_time] = current_time + session[:duration].hours
        end

        running_hours += session[:duration]
        current_time += session[:duration].hours

        # if there are long lessons already, give a break
        if running_hours >= 4
          current_time += 1.hour
          running_hours = 0
        end

        # if the next extension will exceed the day, go the next one
        if (i != cohort.length - 1) && (current_time + cohort[i+1][:duration].hours) > (current_time.beginning_of_day + 18.hours)
          current_time = @private.reset_day(current_time) + 1.day
        end


      end
    end

    weeks = 12
    id = 1
    students = []
    final_students = []
    final_sessions = cohort_sessions.flatten.uniq.each_with_index.map do |session, index|
      session.delete(:duration)
      students << { id: index+1, students: session.delete(:students) }
      session
      # create the session across the week.
      # weeks.times do |t|
      #   Session.create!(session)
      #   session[:start_time] += 1.week
      #   session[:end_time] += 1.week
      #   if t == 5
      #     # add 2 weeks
      #     session[:start_time] += 1.week
      #     session[:end_time] += 1.week
      #   end
      # end
    end
    Session.bulk_insert(values: final_sessions)
    students.each do |h, index|
      h[:students].each do |student|
        final_students << {session_id: h[:id], student_id: student.id }
      end
    end
    SessionsUser.bulk_insert(values: final_students)
  end

  @private = Module.new do
    def self.reset_week
      term_start = Date.iso8601('2019-05-13T08:30:00+08:00')
      term_start.beginning_of_week + 8.hours + 30.minutes
    end

    def self.reset_day date
      date.beginning_of_day + 8.hours + 30.minutes
    end

  end
end