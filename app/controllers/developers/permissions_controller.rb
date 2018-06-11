class Developers::PermissionsController < Developers::ApplicationController
  before_filter -> { authorize :developer, :admin? }

  def index
  end

  def update
    @permission = @developer.permissions.find_or_create_by(value: params[:id].to_i)
  end

  def destroy
    @permission = @developer.permissions.find_by_value! params[:id].to_i
    @permission.destroy
  end
end