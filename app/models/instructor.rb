class Instructor < User
  has_many :subjects
  has_many :lessons
end