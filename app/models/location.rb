class Location < ApplicationRecord
  has_many :sessions
  validates :name, :roomname, presence: true
end
