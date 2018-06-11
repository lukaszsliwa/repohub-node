class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
    add_index :keys, :user_id
  end
end
