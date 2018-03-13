class ChangeLessonFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :lessons, :start_time
    remove_column :lessons, :end_time
  end
end
