# Session for lessons.
class Session < ApplicationRecord
  has_and_belongs_to_many :students
  belongs_to :instructor
  belongs_to :subject
  belongs_to :location
  enum day: Date::DAYNAMES
end
