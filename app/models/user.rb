class User < ApplicationRecord
  has_secure_password

  has_many :user_recipes
  has_many :recipes

  validates :password_digest, presence: true
  validates :username, uniqueness: true, presence: true
end
