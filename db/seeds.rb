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

# create a list of subjects
Subject.destroy_all

Subject.create!([{
    code: "50.003",
    name: "ELEMENTS OF SOFTWARE CONSTRUCTION",
    description: "Introduction to fundamental principles and techniques of software construction.",
    hours_per_week: 5,
    required_facilities: "Classroom",
    required_hours: 0,
    minimum_hours_per_lesson: 1.5
},
{
    code: "50.005",
    name: "COMPUTER SYSTEM ENGINEERING",
    description: "Topics on the engineering of computing and networking systems.",
    hours_per_week: 5,
    required_facilities: "Classroom",
    required_hours: 0,
    minimum_hours_per_lesson: 1.5
},
{
    code: "50.034",
    name: "INTRODUCTION TO PROBABILITY & STATISTICS",
    description: "Key concepts of probability and different statistical distributions.",
    hours_per_week: 5,
    required_facilities: "Lecture_Theatre",
    required_hours: 0,
    minimum_hours_per_lesson: 1.5,
},
{
    code: "02.001",
    name: "WORLD TEXTS AND INTERPRETATION",
    description: "Connections between various texts and the conversations that develop between thinkers throughout history.",
    hours_per_week: 3,
    required_facilities: "Think_Tank",
    required_hours: 0,
    minimum_hours_per_lesson: 1,
},
{
    code: "02.003",
    name: "THEORISING SOCIETY, THE SELF, AND CULTURE",
    description: "Introduction to the social sciences and conceptual tools to understand complex world problems.",
    hours_per_week: 3,
    required_facilities: "Think_Tank",
    required_hours: 0,
    minimum_hours_per_lesson: 1,
},
{
    code: "40.002",
    name: "OPTIMISATION",
    description: "Introduction to a broad range of optimisation algorithms and models.",
    hours_per_week: 5,
    required_facilities: "Lecture_Theatre",
    required_hours: 0,
    minimum_hours_per_lesson: 1.5,
},
{
    code: "01.400",
    name: "CAPSTONE 1",
    description: "To develop an understanding of a multidisciplinary design process and experience through working in teams across pillars to design and construct models or prototypes.",
    hours_per_week: 5,
    required_facilities: "Capstone",
    required_hours: 0,
    minimum_hours_per_lesson: 2,
},
{
    code: "20.101",
    name: "ARCHITECTURE CORE STUDIO 1",
    description: "To establish foundations for architectural design through three projects that build in scope and complexity",
    hours_per_week: 5,
    required_facilities: "Studio",
    required_hours: 0,
    minimum_hours_per_lesson: 2,
}
    ])

p "Created 8 subject"
