class UserMailer < ApplicationMailer

	default from: 'crimsonlockconfirmation@gmail.com'

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to Friday.')
	end

	def forgot_password(user)
		@user = user
		mail(to: @user.email, subject: 'Reset Password')
	end

end
