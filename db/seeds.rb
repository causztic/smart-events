# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'subject_test_list_copy.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|

  t = Subject.new
  t.code = row[0]
  t.name = row[1].gsub("$",",")
  t.description = row[2].gsub("$",",")
  t.hours_per_week = row[3]
  t.facility_hours = row[4].gsub("$",",")
  t.minimum_hours_per_lesson = row[5]
  t.save

  p t
  puts "#{t.code}, #{t.name} saved"
end

puts "There are now #{Subject.count} rows in the transactions table"
