class UserMailer < ApplicationMailer

	default from: 'crimsonlockconfirmation@gmail.com'

	def welcome_email(user)
		@user = user
		@url = 'http://example.com/login'
		mail(to: @user.email, subject: 'Welcome to Friday.')
	end

end
