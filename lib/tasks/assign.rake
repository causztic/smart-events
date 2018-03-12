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
    subjects = Subject.with_students.to_a
    Instructor.all.order("RANDOM()").each do |instructor|
      s = subjects.shift(3)
      instructor.subjects = s
      instructor.save!
    end
    
  end
end
