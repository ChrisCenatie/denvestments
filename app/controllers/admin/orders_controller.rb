class Admin::OrdersController < Admin::BaseController
  def update
    order = Order.find(params[:id])
    if params[:status] == "cancelled"
      order.update(status: "Cancelled")
    elsif params[:status] == "paid"
      order.update(status: "Paid")
    elsif params[:status] == "completed"
      order.update(status: "Completed")
    end
    redirect_to admin_dashboard_path
  end
end
