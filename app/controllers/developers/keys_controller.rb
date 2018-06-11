class Developers::KeysController < Developers::ApplicationController
  def index
    authorize :key, :index?
    @keys = @developer.keys.order('id DESC').all
  end

  def show
    authorize :key, :show?
    @key = @developer.keys.find_by_token! params[:id]
    send_data @key.content, filename: @key.filename, type: 'plain/text'
  end

  def destroy
    @key = @developer.keys.find_by_token! params[:id]
    authorize @key, :destroy?
    @key.destroy
  end
end