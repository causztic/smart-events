# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# table for subjects
Subject.delete_all
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
puts "There are now #{Subject.count} rows in the transactions table"

# table for locations
Location.delete_all
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
puts "There are now #{Location.count} rows in the Location table"

User.delete_all

u = User.new

u.email = "student@hotmail.com"
u.password = "password"
u.password_confirmation = "password"
u.save!
u.add_role :student

u = User.new

u.email = "instructor@hotmail.com"
u.password = "password"
u.password_confirmation = "password"
u.save!
u.add_role :instructor

u = User.new

u.email = "coordinator@hotmail.com"
u.password = "password"
u.password_confirmation = "password"
u.save!
u.add_role :coordinator
