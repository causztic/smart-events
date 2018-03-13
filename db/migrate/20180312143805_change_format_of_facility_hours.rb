class ChangeFormatOfFacilityHours < ActiveRecord::Migration[5.1]
  def change
    change_column :subjects, :facility_hours, :jsonb
  end
end
