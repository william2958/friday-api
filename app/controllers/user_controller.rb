class UserController < ApplicationController
	skip_before_action :authenticate!, only: [:create, :confirm_email]

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

	def create
		@user = User.create!(user_params)

	    render json: @user

	    @user.confirm_token = SecureRandom.urlsafe_base64.to_s
	 	@user.save!

	 	UserMailer.welcome_email(@user).deliver_now
	    
	end

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

	def confirm_email
	    user = User.find_by(confirm_token: params[:id])
	    if user
	      user.email_confirmed = true
	      user.confirm_token = ""
	      user.save
	    else	  
	    end
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :first_name, :last_name, :password)
    end

end