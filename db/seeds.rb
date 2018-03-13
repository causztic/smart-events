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
subjects = []
csv.each do |row|
    next if row.empty?
    t = {}
    t[:code] = row[0]
    t[:name] = row[1].gsub("$",",")
    if row[2].present?
        t[:description] = row[2].gsub("$",",")
    end
    t[:hours_per_week] = row[3]
    t[:facility_hours] = row[4].gsub("$",",")
    t[:minimum_hours_per_lesson] = row[5]
    t[:term_available] = row[6]
    t[:pillar] = row[7]
    subjects << t
end

Subject.bulk_insert(values: subjects)

puts "#{Subject.count} subjects created."
# table for locations
csv_text = File.read(Rails.root.join('lib','seeds','location.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
locations = []
csv.each do |row|
    next if row.empty?
    t = {}
    t[:name] = row['name']
    t[:roomname] = row['roomname']
    t[:capacity] = row['capacity']
    t[:classroom] = row['classroom'].downcase
    t[:locate] = row['locate']
    locations << t
end

Location.bulk_insert(values: locations)

puts "#{Location.count} locations created."
# create a root coordinator
Coordinator.create!({ email: "coordinator@sutd.edu.sg", password: "password", password_confirmation: "password" })

# create a series of students
students = []
400.times do |t|
    students << { email: "freshmore#{t}@sutd.edu.sg", password: "password", password_confirmation: "password" }
end

100.times do |t|
    students << { email: "istd#{t}@sutd.edu.sg", pillar: :ISTD, password: "password", password_confirmation: "password" }
    students << { email: "epd#{t}@sutd.edu.sg", pillar: :EPD, password: "password", password_confirmation: "password" }
    students << { email: "asd#{t}@sutd.edu.sg", pillar: :ASD, password: "password", password_confirmation: "password" }
    students << { email: "esd#{t}@sutd.edu.sg", pillar: :ESD, password: "password", password_confirmation: "password" }
end

puts "Creating students, please wait warmly."
# can't use bulk_insert as password_digest is not rendered with it
Student.create!(students)

puts "#{Student.count} students created.\n"
puts "Run 'rake scrape:faculty' to add in faculty accounts."
puts "Afterwards, run 'rake assign:subjects' to assign demo subjects for the various students."
puts "Finally, do 'rake assign:faculty' to assign random instructors for the subjects"