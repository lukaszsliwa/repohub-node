class RepositoriesController < ApplicationController
  before_filter :find_space
  before_filter :find_repository, only: [:update, :destroy]

  def index
    render json: context.all
  end

  def create
    @repository = Repository.new params_repository
    @repository.space = @space
    @repository.created_by = current_user
    @repository.save!

    render json: @repository
  end

  def update
    @repository.update_attributes! params_repository

    render json: @repository
  end

  def destroy
    @repository.destroy

    render json: @repository
  end

  private

  def find_space
    @space ||= Space.find_by_handle params[:space_id]
  end

  def context
    @space.present? ? @space.repositories : Repository
  end

  def find_repository
    @repository ||= context.find_by_handle! params[:id]
  end

  def params_repository
    params[:repository].permit(:name, :handle)
  end
end
