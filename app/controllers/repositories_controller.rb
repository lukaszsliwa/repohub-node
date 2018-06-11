class RepositoriesController < ApplicationController
  def index
    authorize :repository, :index?
    @repositories = RepositoryPolicy::Scope.new(current_user, Repository).resolve
  end

  def create
    authorize :repository, :create?
    @repository = Repository.create params_repository
  end

  def destroy
    authorize :repository, :destroy?
    @repository = Repository.where(space_id: params[:space_id]).find_by_handle!(params[:id])
    @repository.destroy
  end

  private

  def params_repository
    params[:repository].permit(:handle, :space_id, :allow_me)
  end
end
