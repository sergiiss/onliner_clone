class ApplicationController < ActionController::Base
  before_action :authenticate_user

  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def user_input_to_session
    session[:user_id] = @user.id
  end

  def authenticate_user
    redirect_to new_sessions_path, alert: "Пожалуйста, пройдите аутентификацию" unless current_user
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authorize_admin
    if current_user.name != 'admin'
      redirect_to new_sessions_path, alert: 'У Вас нет прав на это действие, пожалуйста пройдите аутентификацию'
    end
  end
end
