class CallbacksController < ApplicationController
  def show
    @app = Doorkeeper::Application.find_by_name 'RepoFS CLI'
  end
end