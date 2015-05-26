class SpacesController < ApplicationController
  before_filter :find_space, only: [:update, :destroy]

  def index
    render json: Space.all
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
    @space.destroy

    render json: @space
  end

  private

  def find_space
    @space ||= Space.find_by_handle! params[:id]
  end

  def params_space
    params[:space].permit(:name, :handle)
  end
end
