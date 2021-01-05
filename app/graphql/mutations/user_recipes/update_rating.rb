module Mutations
  module UserRecipes
    class UpdateRating < Mutations::BaseMutation
      argument :params, Types::Input::UserRecipes::UpdateType, required: true

      field :user_recipe, Types::UserRecipeType, null: false

      def resolve(params:)
        rating_params = Hash params
        if valid_id?(rating_params[:id]) && valid_rating?(rating_params[:recipe_rating])
          user_recipe = UserRecipe.find(rating_params[:id])
          user_recipe.update!(recipe_rating: rating_params[:recipe_rating])
          Recipe.update_rating(user_recipe.recipe_id)

          { user_recipe: user_recipe }
        else
          if !valid_id?(rating_params[:id])
            GraphQL::ExecutionError.new("No record of UserRecipe with ID #{rating_params[:id]}")
          elsif !valid_rating?(rating_params[:recipe_rating])
            GraphQL::ExecutionError.new("Rating must be between 0 and 5. Can be float.")
          end
        end
      end

      def valid_id?(id)
        UserRecipe.find(id) rescue false
      end

      def valid_rating?(number)
        number > 0 && number <= 5
      end
    end
  end
end
