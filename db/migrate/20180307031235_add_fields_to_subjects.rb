class AddFieldsToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :term_available, :integer
    add_column :subjects, :pillar, :integer, default: 5
  end
end
