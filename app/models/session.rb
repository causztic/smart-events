class Session < ApplicationRecord
  has_many :students
  belongs_to :instructor
  belongs_to :lesson
end