class UserController < ApplicationController
	skip_before_action :authenticate!, only: [:create]

	def create
		@user = User.create!(user_params)
	    @user.save
	    render json: @user
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

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :first_name, :last_name, :password)
    end

end