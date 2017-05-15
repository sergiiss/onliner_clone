class Comment < ApplicationRecord
  has_many   :likes

  belongs_to :post
  validates  :name, presence: true
end
