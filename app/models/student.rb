class Student < User
  has_many :subjects
  has_many :sessions
  enum pillar: ::STUDENT_PILLARS

  scope :freshmores, -> { where(pillar: :Freshmore) }
end