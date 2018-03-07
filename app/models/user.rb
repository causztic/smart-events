class User < ApplicationRecord
  has_secure_password
  validates :type, :email, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? }

  def coordinator?
    type == Coordinator
  end

  def instructor?
    type == Instructor
  end

  def student?
    type == Student
  end

  def display_name
    name.present? ? name : email
  end

end
