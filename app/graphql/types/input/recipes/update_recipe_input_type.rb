module Types
  module Input
    module Recipes
      class UpdateRecipeInputType < Types::BaseInputObject
        argument :id, Integer, required: true
        argument :image, String, required: false
        argument :title, String, required: false
        argument :description, String, required: false
        argument :instructions, String, required: false
        argument :charity_id, String, required: false
        argument :charity_name, String, required: false
        argument :ingredients, [Types::Input::Recipes::RecipeIngredientType], required: false
      end
    end
  end
end
