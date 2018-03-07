class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.float :events_model
      t.string :name
      t.string :description
      t.string :speaker_name
      t.float :duration
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :pillar
    end
  end
end
