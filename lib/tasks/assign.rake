desc "Assigns Subjects and Modules to demo Students and Instructors"
namespace :assign do
  task :subjects => :environment do
    all_subjects = []
    p "Generating a random term for freshmores. A term has 4 subjects."
    Student.freshmores.each do |student|
      subjects = Subject.subjects_this_term(:Freshmore) + Subject.freshmore_hass
      student.subjects = subjects
      student.save!
    end

  end
end
