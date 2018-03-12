class Instructor < User

  has_many :sessions
  has_many :lessons, through: :sessions
  has_and_belongs_to_many :subjects
  
  validates :name, :designation, :faculty, presence: true

  def self.randomized
    all.order("RANDOM()")
  end
end