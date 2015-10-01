class OrdersController < ApplicationController
  def new
    if current_user
      @orders = Order.new
    else
      flash[:notice] = "Please Login or Create an Account to Checkout"
      redirect_to login_path
    end
  end

  def create
    user_order = UserOrder.new(session, params)
    @order = user_order.create_order
    user_order.create_order_items
    session[:cart].clear
    flash[:notice] = "Order successful!"
    redirect_to order_path(@order.id)
  end

  def show
    order = Order.find(params[:id])
    if show_order?(order.user_id)
      @order = order
      @user = User.find(order.user_id)
      loan_quantity = LoanQuantities.new(order)
      @loan_quantities = loan_quantity.loan_quantities
    else
      render file: "/public/404"
    end
  end
end
