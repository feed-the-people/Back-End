class AddCharityNameToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :charity_name, :string
  end
end
