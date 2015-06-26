class Api::SpacesController < Api::ApplicationController
  before_filter :find_space, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create, :update, :destroy]

  def index
    render json: (current_user.admin? ? Space.all : current_user.spaces.all)
  end

  def show
    render json: @space
  end

  def create
    @space = Space.new params_space
    @space.created_by = current_user
    @space.save!

    render json: @space
  end

  def update
    @space.update_attributes! params_space

    render json: @space
  end

  def destroy
    @space.destroy!

    render json: @space
  end

  private

  def find_space
    @space ||= (current_user.admin? ? Space : current_user.spaces).find_by_handle! params[:id]
  end

  def params_space
    params.permit(:name, :handle)
  end
end
