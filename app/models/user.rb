class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_secure_password
  has_one_attached :photo

  has_many :user_recipes
  has_many :recipes

  validates :password_digest, presence: true
  validates :username, uniqueness: true, presence: true

  def get_photo_url
    binding.pry
    if self.photo.attached?
      url_for(self.photo)
    end
  end
end
