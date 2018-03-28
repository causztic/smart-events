desc "Assigns Subjects and Modules to demo Students and Instructors"
namespace :assign do
  task subjects: :environment do
    p "Generating a random term for freshmores."

    Student.freshmores.each do |student|
      subjects = Subject.subjects_this_term(:Freshmore) + Subject.freshmore_hass
      student.subjects = subjects
      student.save!
    end

    p "Generating a random term for pillar students."

    Student.pillar_students.each do |student|
      subjects = Subject.subjects_this_term(student.pillar, 3) + Subject.random_hass
      student.subjects = subjects
    end
  end

  task faculty: :environment do
    p "Assigning faculty to subjects"
    instructors = Instructor.all.order("RANDOM()").select(:id).to_a

    Subject.with_students.to_a.each do |subject|
      if subject.HASS? || subject.FreshmoreHASS?
        subject.instructors << instructors.shift(3)
      elsif subject.Freshmore?
        subject.instructors << instructors.shift(5)
      else
        subject.instructors << instructors.shift(3)
      end
    end

  end
end
