class CopyIdToTokenFromRepositories < ActiveRecord::Migration
  def change
    Repository.update_all 'token = cast(id as text)'
  end
end
