class User < ApplicationRecord
  has_secure_password
  validates :type, :email, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? }
end
