class AddExtraFieldsForUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :designation, :string
    add_column :users, :faculty, :string
    add_column :users, :research_area, :string
  end
end
