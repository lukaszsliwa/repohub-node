class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :handle
      t.integer :created_by_id

      t.timestamps null: false
    end
    add_index :spaces, :handle, unique: true
  end
end
