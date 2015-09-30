class Admin::OrdersController < Admin::BaseController
  def update
    order = Order.find(params[:id])
    if params[:status] == "cancelled"
      order.update(status: "Cancelled")
    end
    redirect_to admin_dashboard_path
  end
end
