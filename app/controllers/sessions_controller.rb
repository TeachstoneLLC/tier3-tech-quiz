class SessionsController < ApplicationController

  skip_before_action :authenticated?, only: [:login, :create]

  # Login
  def create
    @user = User.find_by(username: params[:username])
    @current_user = @user

    if !!@current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect_to root_path
    else
      message = "Username or password invalid"
      redirect_to login_path, notice: message
    end

  end

  # Logout
  def destroy
    @current_user = nil
    session.delete(:user_id)
    redirect_to login_path, notice: "Successfully logged out"
  end

end
