class Admin::AdminsController < Admin::BaseController
  def show
    @completed = Order.where(status: "Completed")
    @paid = Order.where(status: "Paid")
    @cancelled = Order.where(status: "Cancelled")
    @ordered = Order.where(status: "Ordered")
  end

  def edit
    @admin = current_user
  end

  def update
    admin = User.find(current_user.id)
    if admin.update(admin_params)
      redirect_to admin_dashboard_path
    else
      flash[:notice] = admin.errors.full_messages.join(", ")
      redirect_to admin_edit_path
    end
  end

  def admin_params
    params.require(:admin).permit(:username, :password, :full_name, :address)
  end
end
