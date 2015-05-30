class Developers::RepositoriesController < Developers::ApplicationController
  before_filter :find_repository
  before_filter :admin_only

  def update
    @repository.users << @developer

    head :ok
  end

  def destroy
    @repository.repository_users.where(user_id: @developer.id).destroy_all

    head :ok
  end

  private

  def find_repository
    if params[:space_id].present?
      @space ||= Space.find_by_handle! params[:space_id]
      @repository ||= @space.repositories.find_by_handle! params[:id]
    else
      @repository ||= Repository.find_by_handle! params[:id]
    end
  end
end
