class PostsController < ApplicationController
  skip_before_action :authorize, only: [ :index, :show ]

  before_action :set_post, only: [ :edit, :show, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def new
    if current_user.name == 'admin'
      @post = Post.new
    end
  end

  def create
    if current_user.name == 'admin'
      @post = Post.new(post_params)
      if @post.save
        redirect_to @post
      else
        render :new
      end
    else
      redirect_to root_path, alert: 'У Вас нет прав, зайдите под администратором'
    end
  end

  def edit
  end

  def show
    @comments = @post.comments
  end

  def update
    if current_user.name == 'admin'
      if @post.update_attributes(post_params)
        redirect_to @post
      else
        render :edit
      end
    end
  end

  def destroy
    if current_user.name == 'admin'
      @post.destroy
      redirect_to posts_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :summary)
  end
end
