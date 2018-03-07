class RolifyRemoveRoles < ActiveRecord::Migration[5.1]
  def change
    drop_table :roles
    drop_table :users_roles
  end
end
