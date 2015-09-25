class CartItemsController < ApplicationController
  def create
    #check path to know whcih page to render
    cart = session[:cart] || {}
    cart[params[:loan_id]] ||= 0
    cart[params[:loan_id]] += 1
    session[:cart] = cart
    flash[:notice] = cart
    redirect_to loans_path
  end

  def index
  end
end
