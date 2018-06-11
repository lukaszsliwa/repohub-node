class Developers::RepositoriesController < Developers::ApplicationController
  before_filter :find_repository, only: [:update, :destroy]

  def index
    authorize :developer, :index?
    @repositories = Repository.order('id DESC').all
  end

  def update
    authorize :developer, :allow?
    @repository.users << @developer
  end

  def destroy
    authorize :developer, :deny?
    RepositoryUser.where(repository_id: @repository.id, user_id: @developer.id).first!.destroy
  end

  private

  def find_repository
    @repository ||= Repository.find params[:id]
  end
end