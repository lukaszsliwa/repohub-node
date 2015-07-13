class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :image
      t.string :subject

      t.timestamps null: false
    end
    add_index :notifications, :user_id
  end
end
