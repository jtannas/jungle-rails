class SessionsController < ApplicationController
  # Controller for handling user sessions (aka logins)

  def index
    # Sends users to the login page in case they try to load this page
    redirect_to action: 'new'
  end

  def new
    # The login form
  end

  def create
    # The login post handler
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:notice] = "Email or password is invalid"
      render 'new'
    end
  end

  def destroy
    # The logout route
    session[:user_id] = nil
    redirect_to '/'
  end

end
