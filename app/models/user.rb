class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  ROLES = [:coordinator, :student, :instructor]

  if has_role? :student, :instructor
	has_and_belong_to_many :subjects
   end

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
  end
end
