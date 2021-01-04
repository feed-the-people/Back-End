module Types
  module Input
    module UserRecipes
      class UpdateType < Types::BaseInputObject
        argument :id, Float, required: true
        argument :recipe_rating, Float, required: true
      end
    end
  end
end