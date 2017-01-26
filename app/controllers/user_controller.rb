class UserController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]

	def create
		@user = User.create!(user_params)
	    @user.save
	    render json: @user
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :first_name, :last_name, :password)
    end

end