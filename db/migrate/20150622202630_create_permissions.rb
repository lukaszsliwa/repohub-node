class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :user_id
      t.integer :value

      t.timestamps null: false
    end
    add_index :permissions, [:user_id, :value], unique: true
  end
end
