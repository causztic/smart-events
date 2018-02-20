# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
'require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','locations.csv'))'
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    puts row.to_hash
    t = Location.new
    t.roomname = row['roomname']
    t.capacity = row['capacity']
    t.type = row['type']
    t.location = row['location']
    t.save
    puts "#{t.Location"},#{t.type} saved"
end
puts "There are now #{Location.count} rows in the Location table"



Location.delete_all

Location.create!( id: 1, name: 'Think Tank 1', roomname: '1.308', type: 'think_tank', location: 'Building 1, Level 3', capacity: 40.00, status: 1)
Location.create!( id: 1, name: 'Think Tank 2', roomname: '1.308', type: 'think_tank', location: 'Building 1, Level 3', capacity: 40.00, status: 1)

