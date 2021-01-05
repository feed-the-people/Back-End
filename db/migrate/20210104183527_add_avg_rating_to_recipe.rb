class AddAvgRatingToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :avg_rating, :float
  end
end
