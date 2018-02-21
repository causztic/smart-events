class CreateSubjects < ActiveRecord::Migration[5.1]

  def change
    # create_table :subjects, id: false, force: true do |t|
    create_table :subjects do |t|
      t.string :code, null: false
      t.string :name
      t.string :description
      t.float :hours_per_week
      # t.string :required_facilities
      # t.float :required_hours
      t.json :facility_hours
      t.float :minimum_hours_per_lesson
      t.index :code, unique: true
      t.timestamps
    end
  end
end
