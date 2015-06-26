class Repositories::ApplicationController < ApplicationController
  before_filter :find_repository

  def find_repository
    @repository ||= Repository.find params[:repository_id]
    authorize @repository, :allowed?
  end
end
