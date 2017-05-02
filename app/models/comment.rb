class Comment < ApplicationRecord
  belongs_to :post
  validates :name, presence: true
end
