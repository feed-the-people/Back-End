module Types
  module Input
    module Recipes
      class RecipeInputType < Types::BaseInputObject
        argument :user_id, ID, required: true
        argument :title, String, required: true
        argument :description, String, required: true
        argument :instructions, String, required: true
        argument :charity_id, String, required: true
        argument :charity_name, String, required: true
        argument :ingredients, [Types::Input::Recipes::RecipeIngredientType], required: true
      end
    end
  end
end
