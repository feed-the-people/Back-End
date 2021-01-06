module Types
  module Input
    module Ingredients
      class IngredientInputType < Types::BaseInputObject
        argument :recipe_id, ID, required: true
        argument :name, String, required: true
        argument :amount, String, required: true
      end
    end
  end
end
