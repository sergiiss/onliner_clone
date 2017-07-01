class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :index, :show ]

  before_action :set_post, only: [ :edit, :show, :update, :destroy ]
  before_action :authorize_admin, except: [ :index, :show ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
  end

  def show
    @comments = @post.comments.order(:created_at)
    @best_comment = @post.best_comment
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :summary, :image, :rank)
  end
end
