class ApplicationController < ActionController::API
  before_filter :current_user

  def current_user
    @current_user ||= User.find_by_login params[:login]
  end
end
