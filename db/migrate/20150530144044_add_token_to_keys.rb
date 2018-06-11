class AddTokenToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :token, :string
    add_index :keys, :token, unique: true
  end
end
