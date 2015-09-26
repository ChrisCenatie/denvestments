class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :category_list, :cart

  def category_list
    Category.all
  end

  private
  def cart
    Cart.new(session[:cart])
  end
end
