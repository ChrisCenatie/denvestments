class OrdersController < ApplicationController
  def new
    @orders = Order.new()
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
    @total = order.total_cost
    order_items = order.order_items
    @loan_id_quantities = order_items.pluck(:loan_id, :quantity).to_h
  end
end
