class AppsController < ApplicationController
  def index
    @authorized_apps = Doorkeeper::Application.authorized_for(current_user).all
    @apps = Doorkeeper::Application.all - @authorized_apps
  end

  def show
    @app = Doorkeeper::Application.find params[:id]
    @access_token = Doorkeeper::AccessToken.last_authorized_token_for @app, current_user
  end

  def install
    @app = Doorkeeper::Application.find params[:id]
    redirect_to oauth_authorization_path(client_id: @app.uid, redirect_uri: @app.redirect_uri, response_type: 'code')
  end

  def uninstall
    @app = Doorkeeper::Application.find params[:id]
    Doorkeeper::AccessToken.revoke_all_for params[:id], current_user
    redirect_to apps_path, notice: "#{@app.name} was uninstalled successfully."
  end
end
