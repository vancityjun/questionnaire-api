class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.string :first_name, null: false
      t.string :last_name

      t.timestamps
    end
  end
end
