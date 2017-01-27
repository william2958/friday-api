class AuthenticationController < ApplicationController
	skip_before_action :authenticate!

	def authenticate
		command = AuthenticateUser.call(params[:email], params[:password])

		if command.success?
			if User.find_by(email: params[:email]).email_confirmed
				render json: { auth_token: command.result }
			else
				render json: { error: 'Email has not been confirmed!'}, status: :unauthorized
			end
		else
			render json: { error: command.errors }, status: :unauthorized
		end
	end
end