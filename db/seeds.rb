# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# in order: code, name, description, hours_per_week, required_facilities, required_hours, minimum_hours_per_lesson
# subject_list = [
#     [50.003, "ELEMENTS OF SOFTWARE CONSTRUCTION",
#         "Introduction to fundamental principles and techniques of software construction", 5.5,
#     "classroom", 1.5, 1.5 ]
# ]
#
# subject_list.each do |code, name, description, hours_per_week,
#     required_facilities, required_hours, minimum_hours_per_lesson|
#     subject.create( code: code, name: name, description: description, hours_per_week: hours_per_week,
#     required_facilities: required_facilities, required_hours: required_hours, minimum_hours_per_lesson: minimum_hours_per_lesson)
# end

subject_list = [
    ["01.101", "Global Health Technology", "Global Health Technologies provides a multi-disciplinary approach to global health technology design using real world projects and partners.
        The course explores the current state of global health challenges (with special focus on Singapore and her neighbours), and teaches students how to design medical technologies
        (e.g. products, systems) that address these problems. The same technology that is applicable in developing countries will be tested in Singapore as a pilot run, before being
        introduced to the neighboring countries. In their respective project groups, students will work closely with their mentors to identify and solve issues faced by elderly in Singapore. 
        Guest speakers and organized field trips will allow students to have a first-hand experience to global health issues and help them come up with better solutions.",
        2, [{"Classroom":2}], 2],

    ["01.104", "Networked Life", "_____",
        4, [{"Think_Tank":4}], 2]
]

subject_list.each do |code, name, description, hours_per_week, facility_hours, minimum_hours_per_lesson|
    Subject.create( code: code, name: name, description: description, hours_per_week: hours_per_week, facility_hours: facility_hours, minimum_hours_per_lesson: minimum_hours_per_lesson )
end

p "Created #{Subject.count} subjects"


# require 'csv'
#
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'subject_list_1.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# puts csv_text
#
# csv.each do |row|
#   t = Subject.new
#   t.code = row['code']
#   t.name = row['name']
#   t.description = row['description']
#   t.hours_per_week = row['hours_per_week']
#   t.facility_hours = row['facility_hours']
#   t.minimum_hours_per_lesson = row['minimum_hours_per_lesson']
#   t.save
#   puts "#{t.code}, #{t.name} saved"
# end
#
# puts "There are now #{Subject.count} rows in the transactions table"


# create a list of subjects
# Subject.destroy_all
#
# Subject.create!([
#
#     # JAN TERM
# {
#     code: "01.101",
#     name: "Global Health Technology",
#     description: "Global Health Technologies provides a multi-disciplinary approach to global health technology design using real world projects and partners. The course explores the current state of global health challenges (with special focus on Singapore and her neighbours), and teaches students how to design medical technologies (e.g. products, systems) that address these problems. The same technology that is applicable in developing countries will be tested in Singapore as a pilot run, before being introduced to the neighboring countries. In their respective project groups, students will work closely with their mentors to identify and solve issues faced by elderly in Singapore.  Guest speakers and organized field trips will allow students to have a first-hand experience to global health issues and help them come up with better solutions.",
#     hours_per_week: 2,
#     facility_hours: [{"Classroom":2}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "01.104",
#     name: "Networked Life",
#     description: "",
#     hours_per_week: 4,
#     facility_hours: [{"Think_Tank":4}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "01.106",
#     name: "Engineering Management",
#     description: "",
#     hours_per_week: 2,
#     facility_hours: [{"Think_Tank":2}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "01.107",
#     name: "Urban Transportation",
#     description: "",
#     hours_per_week: 4,
#     facility_hours: [{"Think_Tank":4}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "01.111",
#     name: "Culture Formation and Innovation Design",
#     description: "",
#     hours_per_week: 5,
#     facility_hours: [{"Think_Tank":5}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "01.112",
#     name: "Machine Learning",
#     description: "",
#     hours_per_week: 4,
#     facility_hours: [{"Think_Tank":4}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "02.109",
#     name: "Ethics of Leadership",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Classroom":3}],
#     minimum_hours_per_lesson: 3,
# },
# {
#     code: "02.115",
#     name: "Global Shakespeares",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Think_Tank":3}],
#     minimum_hours_per_lesson: 1.5,
# },
# {
#     code: "02.118",
#     name: "Film Studies II: Production",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Lab":3}],
#     minimum_hours_per_lesson: 3,
# },
# {
#     code: "02.127",
#     name: "Satan and His Afterlives in Literature and Film",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Think_Tank":3}],
#     minimum_hours_per_lesson: 1.5,
# },
# {
#     code: "02.130",
#     name: "Slums, Squatters, and Smart Cities: History and Theory of Urban Planning",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Classroom":3}],
#     minimum_hours_per_lesson: 3,
# },
# {
#     code: "02.201",
#     name: "Digital Sociology",
#     description: "",
#     hours_per_week: 2,
#     facility_hours: [{"Think_Tank":2}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "02.202",
#     name: "Organisational Processes",
#     description: "",
#     hours_per_week: 2,
#     facility_hours: [{"Think_Tank":2}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "02.206",
#     name: "Ethics and Social Responsibility",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Think_Tank":3}],
#     minimum_hours_per_lesson: 3,
# },
# {
#     code: "02.207",
#     name: "Organizations and People",
#     description: "",
#     hours_per_week: 3,
#     facility_hours: [{"Think_Tank":3}],
#     minimum_hours_per_lesson: 3,
# },
# {
#     code: "02.208",
#     name: "Microeconomics",
#     description: "",
#     hours_per_week: 4,
#     facility_hours: [{"Classroom":4}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "02.217",
#     name: "Gender, Sexuality and Society",
#     description: "",
#     hours_per_week: 2,
#     facility_hours: [{"Think_Tank":2}],
#     minimum_hours_per_lesson: 2,
# },
# {
#     code: "",
#     name: "",
#     description: "",
#     hours_per_week: 0,
#     facility_hours: [],
#     minimum_hours_per_lesson: 0,
# },
# {
#     code: "",
#     name: "",
#     description: "",
#     hours_per_week: 0,
#     facility_hours: [],
#     minimum_hours_per_lesson: 0,
# },
# {
#     code: "",
#     name: "",
#     description: "",
#     hours_per_week: 0,
#     facility_hours: [],
#     minimum_hours_per_lesson: 0,
# },
# {
#     code: "",
#     name: "",
#     description: "",
#     hours_per_week: 0,
#     facility_hours: [],
#     minimum_hours_per_lesson: 0,
# },
# {
#     code: "",
#     name: "",
#     description: "",
#     hours_per_week: 0,
#     facility_hours: [],
#     minimum_hours_per_lesson: 0,
# },
# {
#     code: "02.001",
#     name: "WORLD TEXTS AND INTERPRETATION",
#     description: "Connections between various texts and the conversations that develop between thinkers throughout history.",
#     hours_per_week: 3,
#     facility_hours: [{"Think_Tank": 2}, {"Lecture_Theatre": 1}],
#     minimum_hours_per_lesson: 1,
# },
# {
#     code: "50.003",
#     name: "ELEMENTS OF SOFTWARE CONSTRUCTION",
#     description: "Introduction to fundamental principles and techniques of software construction.",
#     hours_per_week: 5,
#     facility_hours: [{"Classroom": 1.5}],
#     minimum_hours_per_lesson: 1.5
# },
# {
#     code: "50.005",
#     name: "COMPUTER SYSTEM ENGINEERING",
#     description: "Topics on the engineering of computing and networking systems.",
#     hours_per_week: 5,
#     facility_hours: [{"Classroom": 3}, {"Lecture_Theatre": 2}],
#     minimum_hours_per_lesson: 1.5
# },
# {
#     code: "50.034",
#     name: "INTRODUCTION TO PROBABILITY & STATISTICS",
#     description: "Key concepts of probability and different statistical distributions.",
#     hours_per_week: 5,
#     facility_hours: [{"Classroom": 2}, {"Lecture_Theatre": 3}],
#     minimum_hours_per_lesson: 1.5,
# },
#
# {
#     code: "02.003",
#     name: "THEORISING SOCIETY, THE SELF, AND CULTURE",
#     description: "Introduction to the social sciences and conceptual tools to understand complex world problems.",
#     hours_per_week: 3,
#     facility_hours: [{"Think_Tank": 2}, {"Lecture_Theatre": 1}],
#     minimum_hours_per_lesson: 1,
# },
# {
#     code: "40.002",
#     name: "OPTIMISATION",
#     description: "Introduction to a broad range of optimisation algorithms and models.",
#     hours_per_week: 5,
#     facility_hours: [{"Lecture_Theatre": 5}],
#     minimum_hours_per_lesson: 1.5,
# },
# {
#     code: "01.400",
#     name: "CAPSTONE 1",
#     description: "To develop an understanding of a multidisciplinary design process and experience through working in teams across pillars to design and construct models or prototypes.",
#     hours_per_week: 5,
#     facility_hours: [{"Capstone": 3}, {"Capstone": 2}],
#     minimum_hours_per_lesson: 1.5,
# },
# {
#     code: "20.101",
#     name: "ARCHITECTURE CORE STUDIO 1",
#     description: "To establish foundations for architectural design through three projects that build in scope and complexity",
#     hours_per_week: 5,
#     facility_hours: [{"Studio": 1.5}, {"Lecture_Theatre": 2}],
#     minimum_hours_per_lesson: 1.5,
# }
#     ])
#
# p "Created 0 subject"
