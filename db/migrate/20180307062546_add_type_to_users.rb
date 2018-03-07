class AddTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :users

    create_table :users do |t|
      t.string :type
      t.string :email
      t.string :password_digest
    end
  end
end
