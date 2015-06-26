class Api::Developers::RepositoriesController < Api::Developers::ApplicationController
  before_filter :find_repository
  before_filter :admin_only

  def create
    @repository.users << @developer

    head :ok
  end

  def destroy
    @repository.repository_users.where(user_id: @developer.id).destroy_all

    head :ok
  end

  private

  def find_repository
    if params[:space_handle].present?
      @space ||= Space.find_by_handle! params[:space_handle]
      @repository ||= @space.repositories.find_by_handle! params[:repository_id]
    else
      @repository ||= Repository.in_space(nil).find_by_handle! params[:repository_id]
    end
  end
end
