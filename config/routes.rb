Rails.application.routes.draw do
  resources :sales
  resources :marketings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    resources :marketings
    resources :sales
    
    get 'customer', to: 'customer#index'
    get 'customer/:id', to: 'customer#show'
    put 'customer/:id', to: 'customer#update'
    patch 'customer/:id', to: 'customer#update'

    get 'dashboard/marketing'
    get 'dashboard/sale'
    get 'dashboard', to: 'dashboard#index'

  end

  namespace 'auth' do
    post 'signup', to: 'auth#signup'
    post 'login', to: 'auth#login'
    post 'logout', to: 'auth#logout'
    post 'refresh', to: 'auth#refresh'
    post 'me', to: 'auth#me'
  end
end
