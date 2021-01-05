module Mutations
  module UserRecipes
    class CreateUserRecipe < Mutations::BaseMutation
      argument :params, Types::Input::UserRecipes::CreateInputType, required: true
      type Types::UserRecipeType
      # field :user_recipe, Types::UserRecipeType, null: false

      def resolve(params:)
        user_recipe_params = Hash params
        user_recipe = UserRecipe.create!(user_recipe_params)
        { user_recipe: user_recipe }
      end
    end
  end
end