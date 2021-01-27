class Recipe < ApplicationRecord
  belongs_to :user

  has_many :user_recipes
  has_many :ingredients
  has_many :instructions

  validates :title, presence: true
  validates :description, presence: true
  validates :charity_id, presence: true
  validates :charity_name, presence: true

  def self.update_rating(id)
    recipe = find(id)
    ratings = recipe.user_recipes.where.not(recipe_rating: nil).pluck('recipe_rating')
    recipe.avg_rating = (ratings.sum / ratings.length.to_f).round(1)
    recipe.save
  end
end
