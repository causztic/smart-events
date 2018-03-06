class CreateSubjects < ActiveRecord::Migration[5.1]

  def change
    create_table :subjects do |t|
      t.string :code, null: false
      t.string :name
      t.string :description
      t.float :hours_per_week
      t.json :facility_hours
      t.float :minimum_hours_per_lesson
      t.integer :term_available
      t.integer :pillar, default: 5

      t.index :code, unique: true
      t.timestamps
    end
  end
end
