Rails.application.routes.draw do
  scope '/v1' do
    resources :spaces, except: [:new, :show, :edit] do
      resources :repositories, except: [:new, :show, :edit]
    end
    resources :developers, except: [:new, :show, :edit] do
      resources :repositories, only: [:update, :destroy], controller: 'developers/repositories'
    end
    resources :repositories, except: [:new, :edit]
    resources :keys, only: [:index, :show, :create, :update, :destroy]
  end
end
