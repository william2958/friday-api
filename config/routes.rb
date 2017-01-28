Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	# Get sign in data
	post 'sign_in', to: 'authentication#authenticate'

	# Let the user sign up
	post 'sign_up', to: 'user#create'
	delete 'user', to: 'user#destroy'
	get 'user', to: 'user#index'

	# Account actions
	get 'accounts', to: 'account#index'
	post 'accounts', to: 'account#create'
	patch 'accounts', to: 'account#update'
	post 'accounts_delete', to: 'account#destroy'

	# Receive the confirm email data, which is just a access token
	post 'confirm_email', to: 'user#confirm_email'

	# Handle the user forgetting passwords
	get 'forgot_password', to: 'user#forgot_password'
	post 'change_password', to: 'user#password_reset'

end
