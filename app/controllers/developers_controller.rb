class DevelopersController < ApplicationController
  before_filter :find_developer, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create, :update, :destroy]

  def index
    render json: User.all
  end

  def show
    render json: @developer
  end

  def create
    @developer = User.new params_developer_create
    @developer.created_by = current_user
    @developer.save!

    render json: @developer
  end

  def update
    @developer.update_attributes! params_developer_update

    render json: @developer
  end

  def destroy
    @developer.destroy!

    render json: @developer
  end

  private

  def find_developer
    @developer ||= User.find_by_login! params[:id]
  end

  def params_developer_create
    params.permit(:login, :email)
  end

  def params_developer_update
    params.permit(:email)
  end
end
