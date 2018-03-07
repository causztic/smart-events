class AddLocationToSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :sessions, :location_id, :bigint
  end
end
