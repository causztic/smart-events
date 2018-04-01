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

  protected
  def all_events
    Event.all.includes(:location).map {|e|
      {
        id: e.id,
        type: 'event',
        start_time: e.start_datetime - 8.hours,
        end_time: e.end_datetime - 8.hours,
        title: e.name,
        location: e.location.roomname,
        instructor: e.speaker_name
      }
    }
  end
end
