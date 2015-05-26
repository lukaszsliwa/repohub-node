class Developers::ApplicationController < ApplicationController
  before_filter :find_developer

  def find_developer
    @developer ||= User.find_by_login! params[:developer_id]
  end
end
