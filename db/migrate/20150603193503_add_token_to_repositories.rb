class AddTokenToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :token, :string
    add_index :repositories, :token, unique: true
  end
end
