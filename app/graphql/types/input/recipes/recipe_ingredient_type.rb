module Types
  module Input
    module Recipes
      class RecipeIngredientType < Types::BaseInputObject
        argument :name, String, required: true
        argument :amount, String, required: true
      end
    end
  end
end
