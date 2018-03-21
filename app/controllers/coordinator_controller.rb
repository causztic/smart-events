class CoordinatorController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }
  before_action :set_chat_ids

  def dashboard
    @unassigned_subjects = Subject.left_outer_joins(:instructors).where(users: { id: nil })
  end

  private
  def set_chat_ids
    @chat_ids = ChatRoom.all.select(:id).map &:id
  end
end
