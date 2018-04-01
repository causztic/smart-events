# Students can attend lessons and has many subjects
class Student < User
  has_and_belongs_to_many :subjects
  has_many :sessions_users
  has_many :sessions, -> { distinct }, through: :sessions_users
  enum pillar: ::STUDENT_PILLARS

  scope :freshmores, -> { where(pillar: :Freshmore) }
  scope :pillar_students, -> { where.not(pillar: :Freshmore) }
end
