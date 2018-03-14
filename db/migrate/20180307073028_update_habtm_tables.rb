class UpdateHabtmTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :subjects_users
    create_table :subjects_users, id: false do |t|
      t.belongs_to :subject, index: true
      t.belongs_to :instructor, index: true
      t.belongs_to :student, index: true
    end

    create_table :lessons_users, id: false do |t|
      t.belongs_to :lesson, index: true
      t.belongs_to :instructor, index: true
    end
  end
end
