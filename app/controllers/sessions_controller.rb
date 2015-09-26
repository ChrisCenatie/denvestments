class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: user_params[:username])
    if user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:notice] = "Incorrect login"
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
