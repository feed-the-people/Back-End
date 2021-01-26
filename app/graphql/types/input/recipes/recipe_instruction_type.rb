module Types
  module Input
    module Recipes
      class RecipeInstructionType < Types::BaseInputObject
        argument :description, String, required: true
      end
    end
  end
end
