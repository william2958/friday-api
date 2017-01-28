class AuthenticationController < ApplicationController
	skip_before_action :authenticate!

	# This authenticates the user by password password
	# This is called by the router from '/sign_in'
	def authenticate

		# Check that the user exists
		if User.find_by(email: params[:email])

			# Call AuthenticateUser with an email and password
			# This genereates a token if email and password match
			command = AuthenticateUser.call(params[:email], params[:password])

			# If AuthenticateUser was a success
			if command.success?
				# Check that the user has confirmed their email
				if User.find_by(email: params[:email]).email_confirmed
					# Return the authorization token back to the user
					# Which was returned by JWT
					render json: { auth_token: command.result }
				else
					# Tell the front end the email has not been confirmed
					render json: { 
						status: 'error',
						message: 'Email has not been confirmed!'
					}, status: :unauthorized
				end
			else
				# If the password was incorrect
				render json: {
					status: 'error',
					message: 'Incorrect Password!'
				}, status: :unauthorized
			end
		else
			# Couldn't find the account from the email
			render json: {
				status: 'error',
				message: 'Email could not be found!'
			}, status: 404
		end
	end
end