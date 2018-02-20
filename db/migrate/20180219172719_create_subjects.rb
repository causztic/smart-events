class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects, id: false do |t|
      t.string :code, null: false
      t.string :name
      t.string :description
      t.float :hours_per_week
      # t.string :required_facilities
      # t.float :required_hours
      t.json :facility_hours
      t.float :minimum_hours_per_lesson
      t.timestamps
    end
    add_index :subjects, :code, unique: true
  end
end
