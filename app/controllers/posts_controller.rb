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
    @best_comment = get_best_comment
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

  def get_best_comment
    get_comments_with_max_likes

    if @max_like_comment[1].present?
      if @max_like_comment[0].likes.count != @max_like_comment[1].likes.count
        @max_like_comment[0]
      end
    elsif @max_like_comment[0].present?
      if @max_like_comment[0].likes.count != 0
         @max_like_comment[0]
      end
    end
  end

  def get_comments_with_max_likes
    @max_like_comment =
      @comments.max_by(2) do |comment|
        comment.likes.count
      end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :summary, :image)
  end
end
