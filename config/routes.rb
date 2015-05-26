Rails.application.routes.draw do
  scope '/v1' do
    resources :spaces, except: [:new, :show, :edit] do
      resources :repositories, except: [:new, :show, :edit]
    end
    resources :developers, except: [:new, :show, :edit] do
      resources :keys, except: [:new, :show, :edit], controller: 'developers/keys'
    end
    resources :repositories, except: [:new, :show, :edit]
  end
end
