class Student < User
  has_many :subjects
  has_many :sessions
end