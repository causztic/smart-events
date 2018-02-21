# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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