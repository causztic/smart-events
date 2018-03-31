# Students can attend lessons and has many subjects
class Student < User
  has_and_belongs_to_many :subjects
  has_and_belongs_to_many :sessions, -> { distinct }
  enum pillar: ::STUDENT_PILLARS

  scope :freshmores, -> { where(pillar: :Freshmore) }
  scope :pillar_students, -> { where.not(pillar: :Freshmore) }
end
