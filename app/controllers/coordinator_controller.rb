class CoordinatorController < ApplicationController
  before_action -> { authenticate_role!(Coordinator) }
  before_action :set_chat_ids

  def dashboard
    @unassigned_subjects = Subject.left_outer_joins(:instructors).where(users: { id: nil })
  end

  private
  def set_chat_ids
    @chats = ChatRoom.eager_load(:users).map {|cr| { id: cr.id, name: cr.user_name }}
  end
end
