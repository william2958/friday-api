class AccountController < ApplicationController

  # To access any action here the user must be authenticated by a token
  # calls authenticate! from applicationcontroller

  # Returns all the accounts
  def index
    render json: {
      data: {
        accounts: current_user.accounts.all,
        user: current_user
      }
    }, status: 200
  end

  # Create a new account
  def create
    @account = current_user.accounts.create!(account_params)
    @account.save
    render json: @account
  end

  # Update an account
  def update
    @account = current_user.accounts.find(params[:_id]).update_attributes(account_params)
    render json: @account
  end

  # Destroy an account
  def destroy
    current_user.accounts.find(params[:_id]).delete
    render json: {deleted: true}
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.permit(:_id, :website, :email, :user_name, :password)
    end
end
