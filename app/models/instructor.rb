class Instructor < User
  friendly_id :name, use: :slugged

  has_many :sessions
  has_many :lessons, through: :sessions
  has_and_belongs_to_many :subjects
  
  validates :name, :designation, :faculty, presence: true

end