class AddDevelopersCountToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :users_count, :integer, default: 0
  end
end
