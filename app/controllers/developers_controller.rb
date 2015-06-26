class DevelopersController < ApplicationController
  def index
    authorize :developer, :index?
    @developers = User.order('id DESC').all
  end

  def create
    authorize :developer, :create?
    @developer = User.create params_developer
  end

  def destroy
    authorize :developer, :destroy?
    @developer = User.where(admin: false).find_by_login! params[:id]
    @developer.destroy
  end

  private

  def params_developer
    params[:developer].permit(:login, :email)
  end
end
