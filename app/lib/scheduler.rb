module Scheduler
  def self.generate student_pillar, term=0
    # generate a series of schedules based on the student pillar.
    raise "Pillars must be in #{::STUDENT_PILLARS}" if ::STUDENT_PILLARS.exclude? student_pillar
    subjects = Subject.find_by_sql("SELECT id, name, facility_hours, COUNT(s.student_id) FROM subjects
           INNER JOIN subjects_users s on s.subject_id = subjects.id
           WHERE subjects.pillar = 0 GROUP BY subjects.id;")
    locations = Location.all.select(:id, :name, :roomname, :classroom, :capacity)
    subjects.each do |subject|
      count = item.attributes["count"]
      # use the count and determine the number of sessions needed
      subject.facility_hours.each_pair do |location_name, hours|

      end
    end
  end
end