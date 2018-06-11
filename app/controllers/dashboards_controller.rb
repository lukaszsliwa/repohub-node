class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @notifications = Notification.order('id DESC').all
  end
end