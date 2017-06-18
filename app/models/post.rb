class Post < ApplicationRecord
  has_many :comments

  validates :title, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def best_comment
    # best_comment_candidates = @post.comments.joins(:likes).select("comments.id, count(likes.id) as likes_count").order("likes_count desc").limit(2)

    # best_comment = best_comment_candidates[0] != best_comment_candidates[1] ? best_comment_candidates[0] : nil

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

  private

  def get_comments_with_max_likes
    @max_like_comment =
      comments.max_by(2) do |comment|
        comment.likes.count
      end
  end
end
