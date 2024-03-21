class SessionsController < ApplicationController

  # Skipping authentication checks for login actions to prevent redirect loops
  skip_before_action :authenticated?, only: [:login, :create]

  # Handles the login process
  def create
    # Find the user by username submitted through the login form
    @user = User.find_by(username: params[:username])
    @current_user = @user

    # Authenticate the user. If successful, store the user ID in the session to keep them logged in.
    if !!@current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      redirect_to root_path
    else
      message = "Username or password invalid"
      redirect_to login_path, notice: message
    end
  end

  # Handles the logout process
  def destroy
    # Resetting the entire session for a clean logout, ensuring no leftover session data
    reset_session
    # Redirecting the user to the login page with a success message
    redirect_to login_path, notice: "Successfully logged out"
  end

end
