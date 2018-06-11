class AddRepositoriesCountToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :repositories_count, :integer, default: 0
  end
end
