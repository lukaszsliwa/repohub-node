class AddKeysCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :keys_count, :integer, default: 0
  end
end
