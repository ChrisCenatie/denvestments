class CartItemsController < ApplicationController
  def create
    loan_cart = cart
    loan_cart.add_item(params)
    session[:cart] = loan_cart.data
    redirect_to loans_path
  end

  def index
    @items = cart.items
    @total = cart.total
  end

end
