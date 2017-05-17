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
    @comments = @post.comments
    max_like
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

  def max_like
    @max_like = 0

    @comments.each do |comment|
      number_of_likes = comment.likes.count

      if number_of_likes >= @max_like
        if number_of_likes == @max_like
          number_of_likes = 0
        end
        @max_like = number_of_likes
      end
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :summary)
  end
end
