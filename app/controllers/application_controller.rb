class ApplicationController < ActionController::Base
  before_action :authenticate_user

  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def login
    session[:user_id] = @user.id
  end

  def authenticate_user
    redirect_to new_sessions_path, alert: t(:authentication_failed) unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_admin
    redirect_to new_sessions_path, alert: 'У Вас нет прав на это действие, пожалуйста пройдите авторизацию' if current_user.name != 'admin'
  end
end
