class UsersController < ApplicationController
  # Controller for handling the creation of users

  def index
    # The index route is shown from a failed create
    redirect_to action: 'new'
  end

  def new
    # Shows the signup form
    @user = User.new()
  end

  def create
    # Creates and saves the user profile (if valid)
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      render action: 'new'
    end
  end

  private
    def user_params
      # List of required/permitted new user fields
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
