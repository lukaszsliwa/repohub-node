class SpacesController < ApplicationController
  def index
    authorize :space, :index?
    @spaces = Space.order('id DESC').all
  end

  def create
    authorize :space, :create?
    @space = Space.create params_space
  end

  def destroy
    authorize :space, :destroy?
    @space = Space.find_by_handle! params[:id]
    @space.destroy
  end

  private

  def params_space
    params[:space].permit(:handle)
  end
end
