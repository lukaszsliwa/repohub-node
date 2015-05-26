class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.integer :created_by_id

      t.timestamps null: false
    end
    add_index :users, :login, unique: true
    add_index :users, :email, unique: true
  end
end
