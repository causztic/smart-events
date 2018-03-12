desc "Assigns Subjects and Modules to demo Students and Instructors"
namespace :assign do
  task :subjects => :environment do
    all_subjects = []
    p "Generating a random term for freshmores. A term has 4 subjects."
    student = Student.find_by(email: "freshmore@sutd.edu.sg")
    subjects = Subject.random_sample(3, :Freshmore) + Subject.random_hass
    student.subjects = subjects
    student.save!
  end
end
