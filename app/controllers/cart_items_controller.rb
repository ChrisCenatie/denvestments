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

  def update
    change_quantity(params)
    redirect_to "/cart"
  end

  def destroy
    delete_item(params)
    delete_notice
    redirect_to "/cart"
  end

  private

  def redirect(params)
    redirect_to params[:path]
  end

  def change_quantity(params)
    session[:cart][params[:id]] = params[:item_quantity][:quantity].to_i
  end

  def delete_item(params)
    cart = session[:cart]
    cart.delete(params[:id])
  end

  def delete_notice
    loan = Loan.find(params[:id])
    flash[:notice] = "Successfully removed <a href=/loans/#{params[:id]}>
      #{loan.title}</a> from your cart."
  end
end
