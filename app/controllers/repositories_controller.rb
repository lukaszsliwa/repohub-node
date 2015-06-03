class RepositoriesController < ApplicationController
  before_filter :find_space
  before_filter :find_repository, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create, :update, :destroy]

  def index
    render json: context.all, each_serializer: RepositorySerializer, scope: current_user
  end

  def create
    @repository = Repository.new params_repository
    @repository.space = @space
    @repository.created_by = current_user
    @repository.save!

    render json: @repository
  end

  def show
    render json: @repository.as_json(include: :users)
  end

  def update
    @repository.update_attributes! params_repository

    render json: @repository
  end

  def destroy
    @repository.destroy!

    render json: @repository
  end

  private

  def find_space
    if params[:space_id].present?
      @space ||= current_user.admin? ? Space.find_or_create_by(handle: params[:space_id]) : Space.find_by(handle: params[:space_id])
    end
  end

  def context
    @space.present? ? (current_user.admin ? @space.repositories : current_user.repositories.in_space(@space.id)) : (current_user.admin ? Repository : current_user.repositories)
  end

  def find_repository
    @repository ||= context.find_by_handle! params[:id]
  end

  def params_repository
    params.permit(:name, :handle)
  end
end
