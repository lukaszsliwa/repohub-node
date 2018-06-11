class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.integer :space_id
      t.string :name
      t.string :handle
      t.integer :created_by_id

      t.timestamps null: false
    end
    add_index :repositories, :space_id
    add_index :repositories, :handle
    add_index :repositories, [:space_id, :handle], unique: true
  end
end
