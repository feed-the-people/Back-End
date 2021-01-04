class CreateUserRecipe < ActiveRecord::Migration[6.0]
  def change
    create_table :user_recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.float :amount_donated
      t.float :recipe_rating
    end
  end
end
