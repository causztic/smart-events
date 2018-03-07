class CreateSessionsAndRemoveErrorneous < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.time :start_time
      t.time :end_time
      t.references :lesson
      t.belongs_to :instructor, index: true
    end

    create_table :sessions_users do |t|
      t.references :student
      t.references :session
    end

    # remove errorneous fields
    remove_column :lessons, :students
    remove_column :lessons, :subject
    remove_column :lessons, :location
  end
end
