Rails.application.routes.draw do
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'sign_in', to: 'authentication#authenticate'

  post 'sign_up', to: 'user#create'
  delete 'user', to: 'user#destroy'
  get 'user', to: 'user#index'

  get 'accounts', to: 'account#index'
  post 'accounts', to: 'account#create'
  patch 'accounts', to: 'account#update'
  delete 'accounts', to: 'account#destroy'

end
