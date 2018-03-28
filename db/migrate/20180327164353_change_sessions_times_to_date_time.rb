class ChangeSessionsTimesToDateTime < ActiveRecord::Migration[5.1]
  def change
    remove_column :sessions, :start_time
    remove_column :sessions, :end_time

    add_column :sessions, :start_time, 'timestamp with time zone'
    add_column :sessions, :end_time,   'timestamp with time zone'
  end
end
