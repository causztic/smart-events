# Instructor in the school. Able to communicate with Coordinators to establish better time slots for lessons
class Instructor < User
  has_many :sessions
  has_many :lessons, through: :sessions
  has_and_belongs_to_many :subjects

  validates :name, :designation, :faculty, presence: true
end
