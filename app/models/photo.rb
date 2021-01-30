class Photo < ApplicationRecord
  has_many :user_photos, dependent: :destroy
  has_one_attached :user_photo

  validates :url, presence: true

end
