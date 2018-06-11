class Repositories::DevelopersController < Repositories::ApplicationController
  before_filter :find_developer, only: [:update, :destroy]

  def index
    authorize :developer, :index?
    @developers = User.order('id DESC').all
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

  def find_developer
    @developer ||= User.find_by_login! params[:id]
  end
end