class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name, precision: 11, scale:2
      t.string :roomname, precision: 11, scale:2
      t.string :type, precision: 11, scale:2
      t.integer :capacity, precision: 11, scale:2
      t.string :location, precision: 11, scale:2
      t.integer: status, default: 1
      
      t.timestamps
    end
  end
end
