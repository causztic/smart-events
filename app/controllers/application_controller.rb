class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_partial

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_partial
    @user_partial ||= current_user.type.underscore if current_user
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end

end
