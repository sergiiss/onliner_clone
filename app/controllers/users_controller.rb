class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create, :show ]

  before_action :authorize_admin, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params.except(:avatar))

    if @user.save
      @user.create_avatar(user_params[:avatar])

      login

      redirect_to @user, notice: 'Пользователь был успешно создан.'
    else
      redirect_to new_user_path, alert: 'Пароль или логин неверен'
    end
  end

  def show
    if user?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        current_user.create_avatar(user_params[:avatar])

        format.html { redirect_to current_user, alert: 'Данные пользователя были успешно обновлены.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

    if current_user.admin?
      @user.destroy

      redirect_to users_url, alert: 'Пользователя был успешно удален.'
    end
  end

  private

  def user?
    User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :avatar, :id)
  end
end
