class Developers::KeysController < ApplicationController
  before_filter :find_key, only: [:update, :destroy]

  def index
    render json: @developers.keys.all
  end

  def create
    @key = @developer.keys.create! params_key

    render json: @key
  end

  def update
    @key.update_attributes! params_key

    render json: @key
  end

  def destroy
    @key.destroy

    render json: @key
  end

  private

  def find_key
    @key ||= @developer.keys.find_by_handle! params[:id]
  end

  def params_key
    params[:key].permit(:content)
  end
end
