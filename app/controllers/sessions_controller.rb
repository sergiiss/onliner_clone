class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
    current_user
  end

  def create
    @user = User.find_by(name: params[:name])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_session_path, alert: 'Пароль или логин неверен'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
