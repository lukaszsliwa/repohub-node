class KeysController < ApplicationController
  def index
    @keys = current_user.keys.order('id DESC').all
  end

  def create
    @key = current_user.keys.create params_key
  end

  def destroy
    @key = current_user.keys.find_by_token! params[:id]
    @key.destroy
  end

  private

  def params_key
    params[:key].permit(:token, :content)
  end
end
