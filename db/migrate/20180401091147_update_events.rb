class UpdateEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :events_model
    remove_column :events, :pillar
    add_column    :events, :pillar, :integer
  end
end
