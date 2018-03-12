# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

Subject.delete_all
Location.delete_all
User.delete_all

# table for subjects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'subject.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    next if row.empty?
    t = Subject.new
    t.code = row[0]
    t.name = row[1].gsub("$",",")
    t.description = row[2].gsub("$",",")
    t.hours_per_week = row[3]
    t.facility_hours = row[4].gsub("$",",")
    t.minimum_hours_per_lesson = row[5]
    t.term_available = row[6]
    t.pillar = row[7]
    t.save!
    puts row.to_hash

end
# table for locations
csv_text = File.read(Rails.root.join('lib','seeds','location.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    next if row.empty?
    puts row.to_hash
    t = Location.new
    t.name = row['name']
    t.roomname = row['roomname']
    t.capacity = row['capacity']
    t.classroom = row['classroom'].downcase
    t.locate = row['locate']
    t.save!
end

# create a root coordinator
Coordinator.create!({ email: "coordinator@sutd.edu.sg", password: "password", password_confirmation: "password" })

# create a series of students
Student.create!({ email: "freshmore@sutd.edu.sg", password: "password", password_confirmation: "password" })

Student.create!({ email: "istd@sutd.edu.sg", password: "password", password_confirmation: "password" })
Student.create!({ email: "epd@sutd.edu.sg", password: "password", password_confirmation: "password" })
Student.create!({ email: "asd@sutd.edu.sg", password: "password", password_confirmation: "password" })
Student.create!({ email: "esd@sutd.edu.sg", password: "password", password_confirmation: "password" })

puts "#{Subject.count} subjects created."
puts "#{Location.count} locations created."
puts "Run 'rake scrape:faculty' to add in faculty accounts."
puts "Afterwards, run 'rake assign:subjects' to assign demo subjects for the various students."