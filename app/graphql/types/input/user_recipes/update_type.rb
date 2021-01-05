module Types
  module Input
    module UserRecipes
      class UpdateType < Types::BaseInputObject
        argument :id, Integer, required: true
        argument :recipe_rating, Integer, required: true
      end
    end
  end
end
