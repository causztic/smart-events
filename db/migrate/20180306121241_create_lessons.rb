class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.string :subject
      t.float :duration
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.integer :location_type
      t.integer :students

      t.belongs_to :subject, index: true
      t.timestamps
    end
  end
end
