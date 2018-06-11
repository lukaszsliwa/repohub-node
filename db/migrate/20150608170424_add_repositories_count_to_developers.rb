class AddRepositoriesCountToDevelopers < ActiveRecord::Migration
  def change
    add_column :users, :repositories_count, :integer, default: 0
  end
end
