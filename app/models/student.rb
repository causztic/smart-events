class Student < User
  has_many :subjects
  has_many :sessions
  enum pillar: ::STUDENT_PILLARS
end