class KeysController < ApplicationController
  before_filter :find_key, only: [:show, :update, :destroy]

  def index
    render json: current_user.keys.all
  end

  def show
    render json: @key
  end

  def create
    @key = current_user.keys.create! params_key

    render json: @key
  end

  def update
    @key.token = params[:token]
    @key.save!

    render json: @key
  end

  def destroy
    @key.destroy

    render json: @key
  end

  private

  def find_key
    @key ||= current_user.keys.find_by_token! params[:id]
  end

  def params_key
    params.permit(:token, :content)
  end
end
