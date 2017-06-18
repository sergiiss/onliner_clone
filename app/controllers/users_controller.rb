class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [ :new, :create, :show ]

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.avatar
      @user.create_avatar_for_user(@user, params[:user][:avatar])
    end

    if @user.save
      redirect_to @user, notice: 'Пользователь был успешно создан.'
    else
      redirect_to new_user_path, alert: 'Пароль или логин неверен'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, alert: 'Данные пользователя были успешно обновлены.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.name == 'admin'
      @user.destroy

      redirect_to users_url, alert: 'Пользователя был успешно удален.'
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end


    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :avatar, :id)
    end
end
