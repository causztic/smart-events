desc "Assigns Subjects and Modules to demo Students and Instructors"
namespace :assign do
  task :subjects => :environment do
    
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

  task :faculty => :environment do
    
    p "Assigning faculty to subjects"
    # we assign 3 subjects for each instructor.
    subjects = Subject.randomized_with_students
    Instructor.randomized.each do |instructor|
      s = subjects.take(3)
      subjects.subtract(subjects)
      instructor.subjects = s
      instructor.save!
      break if s.empty?
    end
    
  end
end
