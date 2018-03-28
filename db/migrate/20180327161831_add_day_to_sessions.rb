class AddDayToSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :sessions, :day, :integer, default: 0
  end
end
