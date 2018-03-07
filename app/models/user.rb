class User < ApplicationRecord
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
  end

end
