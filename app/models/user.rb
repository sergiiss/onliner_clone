class User < ApplicationRecord
  has_many :likes

  validates :name, presence: true, uniqueness: true
  has_secure_password
end
