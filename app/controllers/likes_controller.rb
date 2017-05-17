class LikesController < ApplicationController
  before_action :find_comment, only: [ :create, :destroy ]

  def new
    @like = Like.new
  end

  def create
    @like = @comment.likes.create(like_params.merge(:user_id => @current_user.id))

    redirect_to post_path(@comment.post)
  end

  def destroy
    @like = @comment.likes.find_by(:user_id => @current_user.id)
    @like.destroy

    redirect_to post_path(@comment.post)
  end

  private

  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def like_params
    params.permit(:id, :comment_id, :user_id)
  end
end
