module Types
  module Input
    module UserRecipes
      class CreateInputType < Types::BaseInputObject
        argument :user_id, ID, required: true
        argument :recipe_id, ID, required: true
        argument :amount_donated, String, required: true
      end
    end
  end
end