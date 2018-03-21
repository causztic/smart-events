class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_partial

  def current_user
    user_session = session[:user_id]
    cookies.signed[:user_id] = user_session
    @current_user ||= User.find(user_session) if user_session
  rescue ActiveRecord::RecordNotFound
    reset_session
  end

  def user_partial
    @user_partial ||= current_user.type.underscore if current_user
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def authenticate_role!(role)
    authenticate_user!
    head :unauthorized unless current_user.class == role
  end
end
