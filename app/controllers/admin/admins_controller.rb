class Admin::AdminsController < Admin::BaseController
  def show
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
