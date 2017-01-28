class UserController < ApplicationController
	# Controls all user actions

	# Authenticate all the actions except for the following
	skip_before_action :authenticate!, only: [:create, :confirm_email, :forgot_password, :password_reset]

	# Get the user object
	def index
		if current_user
			render json: current_user
		else	
			render json: {
				status: 'error',
				errors: ['Cannot find the account']
			}, status: 404
		end
	end

	# Create a new user object
	def create

		if User.find_by(email: user_params[:email])
			render json: {
		 		status: 'error',
		 		message: 'Email has already been taken!'
		 	}, status: 422
		else

			@user = User.create!(user_params)

		    render json: @user

		    @user.confirm_token = SecureRandom.urlsafe_base64.to_s
		 	@user.save!

		 	UserMailer.welcome_email(@user).deliver_now
		 	
		end
	    
	end

	# Destroy a user object
	def destroy
		if current_user
			current_user.destroy
			render json: {
				status: 'success',
				message: "Account with uid #{@resource.uid} has been destroyed."
			}
		else
			render json: {
				status: 'error',
				errors: ["Unable to locate account for destruction."]
			}, status: 404
		end
	end

	# Confirm the user by checking the confirm_token passed in the url
	def confirm_email
	    user = User.find_by(confirm_token: params[:confirm_token])
	    if user
	    	# Reset all the actions
			user.email_confirmed = true
			user.confirm_token = ""
			user.save	
			render json: {
				status: 'success',
				message: 'Account successfully confirmed!'
			}  
		else
			render json: {
				status: 'error',
				message: 'Account could not be confirmed'
			}, status: 422
	    end
	end

	# Send a forgot password email to a specific user by email
	def forgot_password

		# Find the user through email
		user = User.find_by(email: params[:email])
		if user
			user.confirm_token = SecureRandom.urlsafe_base64.to_s
			user.save!

			# User UserMailer to send the email
			UserMailer.forgot_password(user).deliver_now
			render json: {
				status: 'success',
				message: 'Password Reset email sent!'
			}
		else
			render json: {
				status: 'error',
				message: 'That email has not been registered!'
			}, status: 404
		end

	end

	# Reset the password
	def password_reset
		# Find the user with the confir_token sent by the front-end
		user = User.find_by(confirm_token: params[:confirm_token])
		if user
			# If found, set the password to what was send with the token
			user.password = params[:password]
			user.save!
			render json: {
				status: 'success',
				message: 'Account password has been changed.'
			}
		else
			# Or else render a failure message
			render json: {
				status: 'error',
				message: 'Unable to change the password.'
			}, status: 404
		end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :first_name, :last_name, :password, :confirm_token)
    end

end