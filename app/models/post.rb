class Post < ApplicationRecord
  has_many :comments

  belongs_to :category, optional: true
  accepts_nested_attributes_for :category

  validates :title, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/:style/missing.png", size: { less_than: 1.megabyte },
    url: "/system/:hash.:extension", hash_secret: "longSecretsString"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def best_comment
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
