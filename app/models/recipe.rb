class Recipe < ApplicationRecord
  belongs_to :user
  # has_many :ingredients
  validates :title, presence: true
  validates :description, presence: true
  validates :instructions, presence: true
  # validates :charity_id, presence: true

end
