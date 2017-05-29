class Comment < ApplicationRecord
  has_many   :likes
  belongs_to :post

  validates :name, presence: true

  def from?(user)
    likes.where(user_id: user.id).present?
  end
end
