class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: [ :index, :show, :search_news ]

  before_action :authorize_admin, except: [ :index, :show, :search_news ]

  def index
    @main_categories = Category.where(main_page: 'true').order(:priority)
    @main_posts = Post.where(rank: 1, category_id: Category.where(main_page: 'true')).limit(9).order(created_at: :desc)
  end

  def search_news
    @posts = Post.search(params[:search])
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

  def change_rank
    params.each do |key, value|
      if Post.find_by(:id => key)
        post = Post.find_by(:id => key)

        post.update_attributes(:rank => value)
      end
    end

    redirect_to list_path
  end

  def edit
    set_post
  end

  def show
    set_post

    @comments = @post.comments.order(:created_at)
    @best_comment = @post.best_comment
  end

  def update
    set_post

    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def list
    @posts = Post.all.order(:category_id)
  end

  def destroy
    set_post

    @post.destroy

    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :summary, :image, :rank, :category_id)
  end
end
