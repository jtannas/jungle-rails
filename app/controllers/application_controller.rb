class ApplicationController < ActionController::Base
  # Abstract Base Controller for the entire application

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    # Find or create the cart from the user's cookies
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def update_cart(new_cart)
    # Update the expiration date of the cart
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def current_user
    # Determine the current user from the session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    # Redirect to login if the user is not logged in
    redirect_to '/sessions/new' unless current_user
  end

end
