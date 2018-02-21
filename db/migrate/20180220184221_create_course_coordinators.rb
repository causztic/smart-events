class CreateCourseCoordinators < ActiveRecord::Migration[5.1]
  def change
    create_table :course_coordinators do |t|

      t.timestamps
    end
  end
end
