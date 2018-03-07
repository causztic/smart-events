class Instructor < User
  has_many :subjects
  has_many :lessons

  validates :name, :designation, :faculty, presence: true

end