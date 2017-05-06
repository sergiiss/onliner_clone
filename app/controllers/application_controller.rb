class ApplicationController < ActionController::Base
  before_action :authorize

  protect_from_forgery with: :exception

  helper_method :current_user, :time

  private

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to new_sessions_path, alert: "Пожалуйста, пройдите авторизацию"
    end
  end

  def time
    @time = Time.now.to_s[11..18]
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
end
