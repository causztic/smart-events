class AddSessionGroupToSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :sessions, :session_group, :integer, default: 0
  end
end
