class CreateCourseInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :course_instructors do |t|

      t.timestamps
    end
  end
end
