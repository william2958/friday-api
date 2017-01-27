Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'sign_in', to: 'authentication#authenticate'

  post 'sign_up', to: 'user#create'
  delete 'user', to: 'user#destroy'
  get 'user', to: 'user#index'

  get 'accounts', to: 'account#index'
  post 'accounts', to: 'account#create'
  patch 'accounts', to: 'account#update'
  delete 'accounts', to: 'account#destroy'

  get 'confirm_email/:id', to: 'user#confirm_email', as: 'confirm_email'

  get 'forgot_password', to: 'user#forgot_password'
  get 'password_reset/:id', to: 'user#password_reset', as: 'password_reset'

end
