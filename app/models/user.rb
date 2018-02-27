class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  ROLES = [:coordinator, :student, :instructor]

  if User.has_Role? :student, :instructor
	has_and_belong_to_many :subjects
   end

  def send_message

	if User.has_Role? :instructor, :coordinator

	end
  
  end

  def review_message

	if User.has_Role? :instructor
		#review own message history
	end
  
	if User.has_Role? :coordinator
		#review all message history
	end
  end
end
