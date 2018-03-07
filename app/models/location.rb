class Location < ApplicationRecord

    has_and_belongs_to_many :lessons
    validates :name, :roomname, presence: true


end
