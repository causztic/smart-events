class Student < User
  has_many :subjects
  has_many :lessons, through: :subjects
end