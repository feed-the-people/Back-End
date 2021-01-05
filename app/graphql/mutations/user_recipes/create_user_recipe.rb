module Mutations
  module UserRecipes
    class CreateUserRecipe < Mutations::BaseMutation
      argument :params, Types::Input::UserRecipes::CreateInputType, required: true

      field :user_recipe, Types::UserRecipeType, null: false

      def resolve(params:)
        user_recipe_params = Hash params
        if valid_recipe?(user_recipe_params[:recipe_id]) && valid_user?(user_recipe_params[:user_id])
          user_recipe = UserRecipe.create!(user_recipe_params)
          { user_recipe: user_recipe }
        else
          if !valid_recipe?(user_recipe_params[:recipe_id])
            GraphQL::ExecutionError.new("No record of Recipe with ID #{user_recipe_params[:recipe_id]}")
          elsif !valid_user?(user_recipe_params[:user_id])
            GraphQL::ExecutionError.new("No record of User with ID #{user_recipe_params[:user_id]}")
          end
        end
      end

      def valid_recipe?(id)
        Recipe.find(id) rescue false
      end
      def valid_user?(id)
        User.find(id) rescue false
      end
    end
  end
end