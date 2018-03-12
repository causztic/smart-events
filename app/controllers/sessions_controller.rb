class SessionsController < ApplicationController
  
  def new
    if current_user
      redirect_to_path
    else
      @user = User.new
    end
  end

  def create
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to_path
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to login_path, alert: "Incorrect credentials!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, info: "Successfully logged out."
  end
  
  private
  def redirect_to_path
    
    if current_user.student?
      path = student_dashboard_path 
    end

    redirect_to path, notice: ::NOTICE::LOG_IN_SUCCESS
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end