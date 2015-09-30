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
      @total = order.total_cost
      order_items = order.order_items
      @loan_id_quantities = order_items.pluck(:loan_id, :quantity).to_h
    else
      render file: "/public/404"
    end
  end
end