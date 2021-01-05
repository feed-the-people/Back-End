class ChangeRecipeRatingToIntegerInUserRecipe < ActiveRecord::Migration[6.0]
  def change
    change_column :user_recipes, :recipe_rating, :integer
  end
end
