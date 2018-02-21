class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name, precision: 11, scale:2
      t.string :roomname, precision: 11, scale:2
      t.string :classroom, precision: 11, scale:2
      t.integer :capacity, precision: 11, scale:2
      t.string :locate, precision: 11, scale:2
    
      t.timestamps
    end
  end
end
