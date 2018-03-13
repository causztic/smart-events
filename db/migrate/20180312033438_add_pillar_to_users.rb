class AddPillarToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :pillar, :integer, default: 0
  end
end
