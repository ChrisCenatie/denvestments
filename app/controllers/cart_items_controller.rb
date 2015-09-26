class CartItemsController < ApplicationController
  def create
    loan_cart = cart
    loan_cart.add_item(params)
    session[:cart] = loan_cart.data
    redirect(params)
  end

  def index
    @items = cart.items
    @total = cart.total
  end

  private

  def redirect(params)
    if params[:path] == "category_show"
      redirect_to category_path(params[:category_id])
    else
      redirect_to loans_path
    end
  end
end
