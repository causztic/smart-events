class AddSubjectsToSessions < ActiveRecord::Migration[5.1]
  def change
    add_reference :sessions, :subject, foreign_key: true
  end
end
