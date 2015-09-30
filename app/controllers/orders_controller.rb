class OrdersController < ApplicationController
  def new
    if current_user
      @orders = Order.new()
    else
      flash[:notice] = "Please Login or Create an Account to Checkout"
      redirect_to login_path
    end
  end

  def create
    @order = Order.create(user_id: session[:user_id],
                         card_number: params[:order][:card_number],
                         card_expiration: params[:order][:card_expiration],
                         total_cost: Cart.new(session[:cart]).total,
                         status: "Ordered")
    session[:cart].each do |loan_id, quantity|
      OrderItem.create(loan_id: loan_id, quantity: quantity, order_id: @order.id)
    end
    session[:cart].clear
    flash[:notice] = "Order successful!"
    redirect_to order_path(@order.id)
  end

  def show
    order = Order.find(params[:id])
    if (current_user) && (current_user.id == order.user_id) || (current_admin?)
      @total = order.total_cost
      order_items = order.order_items
      @loan_id_quantities = order_items.pluck(:loan_id, :quantity).to_h
    else
      render file: "/public/404"
    end
  end
end
