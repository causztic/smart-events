desc "Assigns Subjects and Modules to Students and Instructors"
namespace :assign do
  task :subjects => :environment do
    p "Generating a random term for freshmores. A term has 4 subjects."
    Subject.random_sample(4, :Freshmore)
  end
end