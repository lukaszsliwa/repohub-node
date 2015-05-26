class DevelopersController < ApplicationController
  before_filter :find_developer, only: [:update, :destroy]

  def index
    render json: User.all
  end

  def create
    @developer = User.new params_developer
    @developer.created_by = current_user
    @developer.save!

    render json: @developer
  end

  def update
    @developer.update_attributes! params_developer

    render json: @developer
  end

  def destroy
    @developer.destroy

    render json: @developer
  end

  private

  def find_developer
    @developer ||= User.find_by_login! params[:id]
  end

  def params_developer
    params[:developer].permit(:login, :email)
  end
end
