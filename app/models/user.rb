# Base User class.
class User < ApplicationRecord
<<<<<<< HEAD
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  

  ROLES = [:coordinator, :student, :instructor]

  # an instructor teaches many subjects,
  # a student is enrolled to many subjects.
  has_and_belongs_to_many :subjects

  def send_message
    if has_role? :instructor, :coordinator

    end
  end

  def review_message
    if has_role? :instructor
      #review own message history
    end
    if has_role? :coordinator
      #review all message history
    end
=======
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_secure_password

  validates :type, :email, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? }

  def coordinator?
    self.class == Coordinator
  end

  def instructor?
    self.class == Instructor
  end

  def student?
    self.class == Student
  end

  def display_name
    name.present? ? name : email
>>>>>>> origin/master
  end
end
