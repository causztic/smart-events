class Instructor < User
  has_many :subjects
  has_many :sessions
  has_many :lessons, through: :sessions

  validates :name, :designation, :faculty, presence: true

end