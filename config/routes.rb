Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  root 'dashboards#show'

  get '/' => 'admin/dashboards#show'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  resource :dashboard, only: :show
  resources :apps do
    member do
      post :install, :uninstall
    end
  end
  resources :domains
  resources :developers do
    resources :permissions, only: [:index, :update, :destroy], controller: 'developers/permissions'
    resources :repositories, only: [:index, :update, :destroy], controller: 'developers/repositories'
    resources :keys, only: [:index, :show, :destroy], controller: 'developers/keys'
  end
  resources :hooks
  resources :keys
  resources :repositories do
    resources :developers, only: [:index, :update, :destroy], controller: 'repositories/developers'
  end
  resources :spaces
  resource :settings, only: [:edit, :update]

  resource :callback, only: [:show]

  scope '/api/v1', shallow_prefix: 'api', shallow: true do
    resources :spaces, except: [:new, :edit], controller: 'api/spaces' do
      resources :repositories, except: [:new, :show, :edit], controller: 'api/repositories'
    end
    resources :developers, except: [:new, :edit], controller: 'api/developers' do
      resource :repository, only: [:create, :destroy], controller: 'api/developers/repositories'
    end
    resources :repositories, except: [:new, :edit], controller: 'api/repositories'
    resources :keys, only: [:index, :show, :create, :update, :destroy], controller: 'api/keys'
  end
end
