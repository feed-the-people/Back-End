module Types
  module Input
    module Recipes
      class UpdateRecipeType < Types::BaseInputObject
        argument :id, Integer, required: true
        argument :user_id, Integer, required: false
        argument :image, String, required: false
        argument :title, String, required: false
        argument :description, String, required: false
        argument :charity_id, String, required: false
        argument :charity_name, String, required: false
        argument :ingredients, [Types::Input::Recipes::RecipeIngredientType], required: false
        argument :instructions, [Types::Input::Recipes::RecipeInstructionType], required: false
      end
    end
  end
end
