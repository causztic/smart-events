class RemoveUnusedJoins < ActiveRecord::Migration[5.1]
  def change
    drop_table :lessons_users
  end
end
