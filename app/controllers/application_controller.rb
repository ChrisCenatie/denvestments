class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :category_list, :current_user, :cart

  def category_list
    Category.all
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def cart
    Cart.new(session[:cart])
  end

  def show_order?(order_user_id)
    (current_user) && (current_user.id == order_user_id) || (current_admin?)
  end
end
